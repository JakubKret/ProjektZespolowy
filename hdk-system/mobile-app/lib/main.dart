import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/database/app_database.dart';
import 'core/workflows/donor_workflow_service.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/login_screen.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final donorWorkflowServiceProvider = Provider<DonorWorkflowService>((ref) {
  final db = ref.watch(databaseProvider);
  return DonorWorkflowService(db);
});

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
      home: const LoginScreen(),
    );
  }
}
