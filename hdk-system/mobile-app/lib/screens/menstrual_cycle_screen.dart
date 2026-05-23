import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;

import '../main.dart';
import '../core/database/app_database.dart';

final activeCycleProvider = FutureProvider<MenstrualCyclesTableData?>((
  ref,
) async {
  final db = ref.watch(databaseProvider);
  final activeCycles =
      await (db.select(db.menstrualCyclesTable)
            ..where((t) => t.isActive.equals(true))
            ..where(
              (t) => t.donorProfileId.equals(1),
            )) // TODO: ID zalogowanego użytkownika
          .get();

  return activeCycles.isNotEmpty ? activeCycles.first : null;
});

class MenstrualCycleScreen extends ConsumerWidget {
  const MenstrualCycleScreen({Key? key}) : super(key: key);

  Future<void> _startCycle(BuildContext context, WidgetRef ref) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 60)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.pinkAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null) return;
    final workflowService = ref.read(donorWorkflowServiceProvider);
    try {
      await workflowService.startCycle(
        donorProfileId: 1, // TODO: ID zalogowanego użytkownika
        startDate: selectedDate,
      );
      ref.invalidate(activeCycleProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cykl został rozpoczęty. Karencja zaktualizowana.'),
          backgroundColor: Colors.orange,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _endCycle(
    BuildContext context,
    WidgetRef ref,
    DateTime startDate,
  ) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: startDate,
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null) return;

    final workflowService = ref.read(donorWorkflowServiceProvider);
    try {
      await workflowService.closeCycleAndRecomputeEligibility(
        donorProfileId: 1, // TODO: ID zalogowanego użytkownika
        endDate: selectedDate,
      );
      ref.invalidate(activeCycleProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cykl zakończony. Możesz oddać krew za 3 dni!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeCycleAsync = ref.watch(activeCycleProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFD32F2F)),
        title: const Text(
          'Kalendarz Fizjologiczny',
          style: TextStyle(
            color: Color(0xFFD32F2F),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: activeCycleAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFD32F2F)),
        ),
        error: (err, stack) => Center(child: Text('Błąd: $err')),
        data: (activeCycle) {
          final isCycleActive = activeCycle != null;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.water_drop,
                  size: 60,
                  color: Colors.pinkAccent,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Śledzenie Cyklu Menstruacyjnego',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Zgodnie z wytycznymi medycznymi, oddawanie krwi podczas miesiączki oraz 3 dni po jej zakończeniu jest przeciwwskazane ze względu na ryzyko utraty żelaza. Poniższy moduł automatycznie wstrzyma Twoje powiadomienia i przeliczy bezpieczną datę donacji.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isCycleActive
                        ? Colors.orange.shade50
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCycleActive
                          ? Colors.orange.shade200
                          : Colors.green.shade200,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isCycleActive
                            ? 'Miesiączka w toku'
                            : 'Brak przeciwskazań',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isCycleActive
                              ? Colors.orange.shade800
                              : Colors.green.shade800,
                        ),
                      ),
                      if (isCycleActive) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Rozpoczęto: ${DateFormat('dd.MM.yyyy').format(activeCycle.startDate)}',
                          style: TextStyle(color: Colors.orange.shade800),
                        ),
                      ],
                    ],
                  ),
                ),
                const Spacer(),

                if (!isCycleActive)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _startCycle(context, ref),
                    child: const Text(
                      'Zaznacz rozpoczęcie miesiączki',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () =>
                        _endCycle(context, ref, activeCycle.startDate),
                    child: const Text(
                      'Zaznacz zakończenie miesiączki',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
