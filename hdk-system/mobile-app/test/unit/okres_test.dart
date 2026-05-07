import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdk_mobile_app/core/database/app_database.dart';
import 'package:hdk_mobile_app/core/database/daos/menstrual_cycles_dao.dart';
import 'package:hdk_mobile_app/core/database/tables/menstrual_cycles.dart';

void main() {
  late AppDatabase db;
  late MenstrualCyclesDao dao;
  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = db.menstrualCyclesDao;
  });
  tearDown(() async {
    await db.close();});

  MenstrualCyclesTableCompanion cycleFor(
    int donorId, {
    required DateTime startDate,
  }) {
    return MenstrualCyclesTableCompanion.insert(
      donorProfileId: donorId,
      startDate: startDate,
    );
  }

  group('createCycleAndRecalculate', () {
    test('inserts a new active cycle and returns its id', () async {
      final id = await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 5, 1)),
      );

      expect(id, isPositive);

      final rows = await db.select(db.menstrualCyclesTable).get();
      expect(rows, hasLength(1));
      expect(rows.single.id, id);
      expect(rows.single.donorProfileId, 1);
      expect(rows.single.isActive, isTrue);
    });

    test('deactivates the previously active cycle for the same donor',
        () async {
      final firstId = await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 4, 1)),
      );
      final secondId = await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 5, 1)),
      );

      final rows = await (db.select(db.menstrualCyclesTable)
            ..orderBy([(t) => OrderingTerm.asc(t.id)]))
          .get();

      expect(rows, hasLength(2));
      expect(rows[0].id, firstId);
      expect(rows[0].isActive, isFalse,
          reason: 'previous cycle should be deactivated');
      expect(rows[1].id, secondId);
      expect(rows[1].isActive, isTrue,
          reason: 'newest cycle should be active');
    });

    test('does not affect cycles of other donors', () async {
      await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 4, 1)),
      );
      await dao.createCycleAndRecalculate(
        cycleFor(2, startDate: DateTime(2026, 5, 1)),
      );

      final donor1Active = await (db.select(db.menstrualCyclesTable)
            ..where((t) => t.donorProfileId.equals(1) & t.isActive.equals(true)))
          .get();
      final donor2Active = await (db.select(db.menstrualCyclesTable)
            ..where((t) => t.donorProfileId.equals(2) & t.isActive.equals(true)))
          .get();

      expect(donor1Active, hasLength(1));
      expect(donor2Active, hasLength(1));
    });

    test('invokes the recalculate callback with the donor id', () async {
      int? receivedDonorId;
      await dao.createCycleAndRecalculate(
        cycleFor(42, startDate: DateTime(2026, 5, 1)),
        recalculate: (donorId) async {
          receivedDonorId = donorId;
        },
      );

      expect(receivedDonorId, 42);
    });
  });

  group('closeActiveCycle', () {
    test('sets endDate and marks the active cycle as inactive', () async {
      await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 5, 1)),
      );

      final endDate = DateTime(2026, 5, 7);
      await dao.closeActiveCycle(1, endDate: endDate);

      final row = await (db.select(db.menstrualCyclesTable)
            ..where((t) => t.donorProfileId.equals(1)))
          .getSingle();

      expect(row.isActive, isFalse);
      expect(row.endDate, endDate);
    });

    test('uses DateTime.now() when no endDate is provided', () async {
      await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 5, 1)),
      );

      final before = DateTime.now();
      await dao.closeActiveCycle(1);
      final after = DateTime.now();

      final row = await (db.select(db.menstrualCyclesTable)
            ..where((t) => t.donorProfileId.equals(1)))
          .getSingle();

      expect(row.endDate, isNotNull);
      expect(
        row.endDate!.isAfter(before.subtract(const Duration(seconds: 1))),
        isTrue,
      );
      expect(
        row.endDate!.isBefore(after.add(const Duration(seconds: 1))),
        isTrue,
      );
    });

    test('does nothing when there is no active cycle', () async {
      await expectLater(dao.closeActiveCycle(99), completes);

      final rows = await db.select(db.menstrualCyclesTable).get();
      expect(rows, isEmpty);
    });

    test('invokes the recalculate callback with the donor id', () async {
      await dao.createCycleAndRecalculate(
        cycleFor(7, startDate: DateTime(2026, 5, 1)),
      );

      int? receivedDonorId;
      await dao.closeActiveCycle(
        7,
        recalculate: (donorId) async {
          receivedDonorId = donorId;
        },
      );

      expect(receivedDonorId, 7);
    });
  });

  group('watchCyclesForDonor', () {
    test('emits cycles ordered by startDate descending', () async {
      await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 1, 1)),
      );
      await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 5, 1)),
      );
      await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 3, 1)),
      );

      final cycles = await dao.watchCyclesForDonor(1).first;

      expect(cycles.map((c) => c.startDate).toList(), [
        DateTime(2026, 5, 1),
        DateTime(2026, 3, 1),
        DateTime(2026, 1, 1),
      ]);
    });

    test('only emits cycles for the requested donor', () async {
      await dao.createCycleAndRecalculate(
        cycleFor(1, startDate: DateTime(2026, 5, 1)),
      );
      await dao.createCycleAndRecalculate(
        cycleFor(2, startDate: DateTime(2026, 5, 2)),
      );

      final cycles = await dao.watchCyclesForDonor(1).first;

      expect(cycles, hasLength(1));
      expect(cycles.single.donorProfileId, 1);
    });
  });
}
