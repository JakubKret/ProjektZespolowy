import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'package:drift/drift.dart' as drift;

import '../main.dart'; // import providerów bazy danych
import '../core/database/app_database.dart';

// Provider pobierający placówki z bazy
final bloodCentersProvider = FutureProvider<List<BloodCentersTableData>>((
  ref,
) async {
  final db = ref.watch(databaseProvider);
  return await db.select(db.bloodCentersTable).get();
});

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  BloodCentersTableData? _nearestCenter;
  double? _distanceToNearest;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  // Pobieranie GPS i liczenie dystansu
  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });

    _calculateNearestCenter();

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          10.0,
        ),
      );
    }
  }

  void _calculateNearestCenter() {
    if (_currentPosition == null) return;

    // Pobieramy listę placówek z providera
    final centersAsync = ref.read(bloodCentersProvider);
    centersAsync.whenData((centers) {
      if (centers.isEmpty) return;

      double minDistance = double.infinity;
      BloodCentersTableData? nearest;

      for (var center in centers) {
        if (center.latitude == null || center.longitude == null) continue;

        final distance = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          center.latitude!,
          center.longitude!,
        );

        if (distance < minDistance) {
          minDistance = distance;
          nearest = center;
        }
      }

      setState(() {
        _nearestCenter = nearest;
        _distanceToNearest = minDistance / 1000; // konwersja na kilometry
      });
    });
  }

  Future<void> _seedDatabase() async {
    final db = ref.read(databaseProvider);
    final existing = await db.select(db.bloodCentersTable).get();

    if (existing.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Baza ma już dane!')));
      return;
    }

    try {
      // Używamy drift.Value dla pól tekstowych, jeśli w schemacie są nullable
      await db
          .into(db.bloodCentersTable)
          .insert(
            BloodCentersTableCompanion.insert(
              name: 'RCKiK we Wrocławiu',
              city: 'Wrocław',
              address: const drift.Value(
                'Czerwonego Krzyża 5/9',
              ), // Używamy address zamiast street
              latitude: const drift.Value(51.1135),
              longitude: const drift.Value(17.0622),
            ),
          );

      await db
          .into(db.bloodCentersTable)
          .insert(
            BloodCentersTableCompanion.insert(
              name: 'RCKiK Opole - Terenowy Oddział w Nysie',
              city: 'Nysa',
              address: const drift.Value('Piłsudskiego 47'),
              latitude: const drift.Value(50.4735),
              longitude: const drift.Value(17.3344),
            ),
          );

      await db
          .into(db.bloodCentersTable)
          .insert(
            BloodCentersTableCompanion.insert(
              name: 'RCKiK w Warszawie',
              city: 'Warszawa',
              address: const drift.Value('Saska 63/75'),
              latitude: const drift.Value(52.2394),
              longitude: const drift.Value(21.0536),
            ),
          );

      ref.invalidate(bloodCentersProvider);
      Future.delayed(
        const Duration(milliseconds: 500),
        _calculateNearestCenter,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pobrano placówki testowe!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd zapisu: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final centersAsync = ref.watch(bloodCentersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Placówki RCKiK',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          // Przycisk ratunkowy do wgrania danych!
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFFD32F2F)),
            tooltip: 'Wgraj testowe placówki',
            onPressed: _seedDatabase,
          ),
        ],
      ),
      body: Stack(
        children: [
          centersAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Błąd bazy: $err')),
            data: (centers) {
              Set<Marker> markers = centers
                  .where((c) => c.latitude != null && c.longitude != null)
                  .map((c) {
                    return Marker(
                      markerId: MarkerId(c.id.toString()),
                      position: LatLng(c.latitude!, c.longitude!),
                      infoWindow: InfoWindow(
                        title: c.name,
                        snippet: '${c.address}, ${c.city}',
                      ),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed,
                      ),
                    );
                  })
                  .toSet();

              return GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(52.0693, 19.4803), // Centrum Polski
                  zoom: 6.0,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: false, // Własny przycisk na dole
                markers: markers,
                onMapCreated: (controller) => _mapController = controller,
              );
            },
          ),

          // Pływający przycisk lokalizacji
          Positioned(
            right: 16,
            bottom: _nearestCenter != null
                ? 140
                : 24, // Podnosi się, jeśli jest karta
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _determinePosition,
              child: const Icon(Icons.my_location, color: Color(0xFFD32F2F)),
            ),
          ),

          // Karta z najbliższą placówką (pojawia się tylko, gdy ją policzymy)
          if (_nearestCenter != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_hospital,
                        color: Color(0xFFD32F2F),
                        size: 40,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Najbliższa placówka:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _nearestCenter!.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${_nearestCenter!.address}, ${_nearestCenter!.city}',
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${_distanceToNearest!.toStringAsFixed(1)} km',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD32F2F),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
