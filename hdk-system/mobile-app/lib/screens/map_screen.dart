import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:drift/drift.dart' as drift;

import '../core/database/app_database.dart';
import '../core/providers/app_providers.dart';

class BloodStock {
  final String bloodType;
  final int units;
  final BloodStockLevel level;

  const BloodStock({
    required this.bloodType,
    required this.units,
    required this.level,
  });
}

enum BloodStockLevel { critical, low, moderate, good }

class CenterWithDistance {
  final BloodCentersTableData center;
  final double distanceKm;

  const CenterWithDistance({required this.center, required this.distanceKm});
}

Map<int, List<BloodStock>> _generateMockStocks(
  List<BloodCentersTableData> centers,
) {
  final rng = Random(42);
  const types = ['0 Rh+', '0 Rh-', 'A Rh+', 'A Rh-', 'B Rh+', 'B Rh-', 'AB Rh+', 'AB Rh-'];

  return {
    for (final c in centers)
      c.id: types.map((t) {
        final units = rng.nextInt(50);
        final BloodStockLevel level;
        if (units < 5) {
          level = BloodStockLevel.critical;
        } else if (units < 15) {
          level = BloodStockLevel.low;
        } else if (units < 30) {
          level = BloodStockLevel.moderate;
        } else {
          level = BloodStockLevel.good;
        }
        return BloodStock(bloodType: t, units: units, level: level);
      }).toList(),
  };
}

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _showFacilityList = false;
  int? _expandedCenterId;
  Map<int, List<BloodStock>> _bloodStocks = {};
  List<CenterWithDistance> _sortedCenters = [];
  bool _shortageAlertShown = false;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

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

    _calculateSortedCenters();

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          10.0,
        ),
      );
    }
  }

  void _calculateSortedCenters() {
    if (_currentPosition == null) return;

    final centersAsync = ref.read(bloodCentersProvider);
    centersAsync.whenData((centers) {
      if (centers.isEmpty) return;

      _bloodStocks = _generateMockStocks(centers);

      final withDistance = <CenterWithDistance>[];
      for (var center in centers) {
        if (center.latitude == null || center.longitude == null) continue;

        final distance = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          center.latitude!,
          center.longitude!,
        );
        withDistance.add(
          CenterWithDistance(center: center, distanceKm: distance / 1000),
        );
      }

      withDistance.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));

      setState(() {
        _sortedCenters = withDistance;
      });

      _checkBloodShortage();
    });
  }

  void _checkBloodShortage() {
    if (_shortageAlertShown || _sortedCenters.isEmpty) return;

    final dashboard = ref.read(donorDashboardProvider).value;
    if (dashboard == null) return;

    final canDonate = dashboard.eligibility.canDonate;
    if (!canDonate) return;

    final userBloodType = dashboard.bloodTypeLabel;
    if (userBloodType == 'Nie podano') return;

    final nearest = _sortedCenters.first;
    final stocks = _bloodStocks[nearest.center.id];
    if (stocks == null) return;

    final userStock = stocks.where((s) => s.bloodType == userBloodType).toList();
    if (userStock.isEmpty) return;

    final stock = userStock.first;
    if (stock.level == BloodStockLevel.critical ||
        stock.level == BloodStockLevel.low) {
      _shortageAlertShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _showShortageAlert(nearest, stock, userBloodType);
      });
    }
  }

  void _showShortageAlert(
    CenterWithDistance nearest,
    BloodStock stock,
    String userBloodType,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Color(0xFFD32F2F),
          size: 48,
        ),
        title: const Text(
          'Twoja krew jest potrzebna!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'W najbliższej placówce brakuje krwi z Twojej grupy ($userBloodType).',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_hospital, color: Color(0xFFD32F2F)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nearest.center.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '${nearest.distanceKm.toStringAsFixed(1)} km od Ciebie',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _stockLevelDot(stock.level),
                const SizedBox(width: 8),
                Text(
                  'Stan: ${stock.units} j. — ${_stockLevelLabel(stock.level)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _stockColor(stock.level),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Możesz teraz oddać krew i pomóc potrzebującym!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Zamknij'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _showFacilityList = true;
                _expandedCenterId = nearest.center.id;
              });
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Zobacz placówkę'),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _seedDatabase() async {
    final db = ref.read(databaseProvider);
    final existing = await db.select(db.bloodCentersTable).get();

    if (existing.isNotEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Baza ma już dane!')));
      return;
    }

    try {
      await db
          .into(db.bloodCentersTable)
          .insert(
            BloodCentersTableCompanion.insert(
              name: 'RCKiK we Wrocławiu',
              city: 'Wrocław',
              address: const drift.Value('Czerwonego Krzyża 5/9'),
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

      invalidateDonorData(ref);
      Future.delayed(
        const Duration(milliseconds: 500),
        _calculateSortedCenters,
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
        title: Text(
          _showFacilityList ? 'Podgląd placówek' : 'Placówki RCKiK',
          style: const TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: _showFacilityList
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFD32F2F)),
                onPressed: () => setState(() {
                  _showFacilityList = false;
                  _expandedCenterId = null;
                }),
              )
            : null,
        actions: [
          if (!_showFacilityList)
            IconButton(
              icon: const Icon(Icons.list_alt, color: Color(0xFFD32F2F)),
              tooltip: 'Podgląd placówek',
              onPressed: () => setState(() => _showFacilityList = true),
            ),
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFFD32F2F)),
            tooltip: 'Wgraj testowe placówki',
            onPressed: _seedDatabase,
          ),
        ],
      ),
      body: _showFacilityList
          ? _buildFacilityList()
          : _buildMapView(centersAsync),
    );
  }

  Widget _buildMapView(AsyncValue<List<BloodCentersTableData>> centersAsync) {
    return Stack(
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
                target: LatLng(52.0693, 19.4803),
                zoom: 6.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: markers,
              onMapCreated: (controller) => _mapController = controller,
            );
          },
        ),

        Positioned(
          right: 16,
          bottom: _sortedCenters.isNotEmpty ? 140 : 24,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: _determinePosition,
            child: const Icon(Icons.my_location, color: Color(0xFFD32F2F)),
          ),
        ),

        if (_sortedCenters.isNotEmpty)
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: GestureDetector(
              onTap: () => setState(() {
                _showFacilityList = true;
                _expandedCenterId = _sortedCenters.first.center.id;
              }),
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
                              _sortedCenters.first.center.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${_sortedCenters.first.center.address}, ${_sortedCenters.first.center.city}',
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '${_sortedCenters.first.distanceKm.toStringAsFixed(1)} km',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD32F2F),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Icon(
                            Icons.chevron_right,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFacilityList() {
    if (_currentPosition == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Włącz lokalizację,\naby zobaczyć placówki w pobliżu',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _determinePosition,
              icon: const Icon(Icons.my_location),
              label: const Text('Włącz lokalizację'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
              ),
            ),
          ],
        ),
      );
    }

    if (_sortedCenters.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      itemCount: _sortedCenters.length,
      itemBuilder: (context, index) {
        final item = _sortedCenters[index];
        final isExpanded = _expandedCenterId == item.center.id;
        final stocks = _bloodStocks[item.center.id] ?? [];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _FacilityCard(
            item: item,
            isExpanded: isExpanded,
            stocks: stocks,
            index: index,
            onTap: () => setState(() {
              _expandedCenterId = isExpanded ? null : item.center.id;
            }),
            onMapTap: item.center.latitude != null
                ? () {
                    setState(() => _showFacilityList = false);
                    _mapController?.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        LatLng(
                          item.center.latitude!,
                          item.center.longitude!,
                        ),
                        14.0,
                      ),
                    );
                  }
                : null,
          ),
        );
      },
    );
  }

  static Widget _stockLevelDot(BloodStockLevel level) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _stockColor(level),
      ),
    );
  }

  static Color _stockColor(BloodStockLevel level) {
    switch (level) {
      case BloodStockLevel.critical:
        return const Color(0xFFD32F2F);
      case BloodStockLevel.low:
        return Colors.orange;
      case BloodStockLevel.moderate:
        return Colors.amber.shade700;
      case BloodStockLevel.good:
        return Colors.green;
    }
  }

  static String _stockLevelLabel(BloodStockLevel level) {
    switch (level) {
      case BloodStockLevel.critical:
        return 'Krytyczny';
      case BloodStockLevel.low:
        return 'Niski';
      case BloodStockLevel.moderate:
        return 'Umiarkowany';
      case BloodStockLevel.good:
        return 'Dobry';
    }
  }
}

class _FacilityCard extends StatelessWidget {
  final CenterWithDistance item;
  final bool isExpanded;
  final List<BloodStock> stocks;
  final int index;
  final VoidCallback onTap;
  final VoidCallback? onMapTap;

  const _FacilityCard({
    required this.item,
    required this.isExpanded,
    required this.stocks,
    required this.index,
    required this.onTap,
    this.onMapTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isExpanded ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isExpanded
            ? const BorderSide(color: Color(0xFFD32F2F), width: 1.5)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? const Color(0xFFD32F2F)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: index == 0
                            ? const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 22,
                              )
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.center.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${item.center.address ?? ''}, ${item.center.city}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          if (item.center.phone != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              item.center.phone!,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${item.distanceKm.toStringAsFixed(1)} km',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD32F2F),
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isExpanded) _buildExpandedContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                const Icon(
                  Icons.bloodtype,
                  size: 18,
                  color: Color(0xFFD32F2F),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Stan zapasów krwi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: stocks.length,
              itemBuilder: (context, i) {
                final stock = stocks[i];
                return _BloodStockTile(stock: stock);
              },
            ),
          ),
          if (onMapTap != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onMapTap,
                  icon: const Icon(Icons.map),
                  label: const Text('Pokaż na mapie'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFD32F2F),
                    side: const BorderSide(color: Color(0xFFD32F2F)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox(height: 16),
        ],
      ),
    );
  }

}

class _BloodStockTile extends StatelessWidget {
  final BloodStock stock;

  const _BloodStockTile({required this.stock});

  @override
  Widget build(BuildContext context) {
    final color = _MapScreenState._stockColor(stock.level);

    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            stock.bloodType.replaceAll(' Rh', '\n'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${stock.units} j.',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
