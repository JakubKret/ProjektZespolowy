import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bootstrap/test_data_seed.dart';
import 'core/providers/app_providers.dart';
import 'core/session/donor_session.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_screen.dart';

export 'core/providers/app_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: Krwiodawstwo()));
}

class Krwiodawstwo extends StatelessWidget {
  const Krwiodawstwo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krwiodawstwo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD32F2F)),
        useMaterial3: true,
      ),
      home: const _SessionGate(),
    );
  }
}

class _SessionGate extends ConsumerStatefulWidget {
  const _SessionGate();

  @override
  ConsumerState<_SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends ConsumerState<_SessionGate> {
  late Future<int?> _restoreFuture;

  @override
  void initState() {
    super.initState();
    _restoreFuture = _initTestSession();
  }

  Future<int?> _initTestSession() async {
    final restored = await tryRestoreSession(ref);
    if (restored != null) return restored;

    final db = ref.read(databaseProvider);
    final workflow = ref.read(donorWorkflowServiceProvider);
    final donorId = await TestDataSeed.ensureTestUser(db, workflow);

    ref.read(currentDonorIdProvider.notifier).set(donorId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('logged_in_donor_id', donorId);

    return donorId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: _restoreFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
            ),
          );
        }

        if (snapshot.data != null) {
          return const MainNavigationScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
