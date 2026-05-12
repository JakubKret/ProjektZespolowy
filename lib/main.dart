import 'package:flutter/material.dart';

import 'core/database/app_database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  runApp(HdkApp(database: database));
}

class HdkApp extends StatelessWidget {
  const HdkApp({super.key, required this.database});
  final AppDatabase database;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDK',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HDK')),
      body: const Center(child: Text('Hello, donor!')),
    );
  }
}
