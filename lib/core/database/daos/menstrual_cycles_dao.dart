import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/menstrual_cycles.dart';
part 'menstrual_cycles_dao.g.dart';
typedef RecalculateCycleBlocker = Future<void>Function(int donorProfileId);



@DriftAccessor(tables: [MenstrualCyclesTable])
class MenstrualCyclesDao extends DatabaseAccessor<AppDatabase>
    with _$MenstrualCyclesDaoMixin {
  MenstrualCyclesDao(super.db);

  Future<int> createCycleAndRecalculate(
    MenstrualCyclesTableCompanion cycle, {
    RecalculateCycleBlocker? recalculate,
  }) async {
    final donorId = cycle.donorProfileId.value;
    return transaction(() async {
      await (update(menstrualCyclesTable)
            ..where((t) => t.donorProfileId.equals(donorId) & t.isActive.equals(true)))
          .write(const MenstrualCyclesTableCompanion(isActive: Value(false)));
      final cycleId = await into(menstrualCyclesTable).insert(cycle);
      if (recalculate != null) {
        await recalculate(donorId);
      }
      return cycleId;
    });
  }
  Future<void> closeActiveCycle( int donorProfileId, { DateTime? endDate,
    RecalculateCycleBlocker? recalculate,
  }) async {
    final resolvedEndDate = endDate ?? DateTime.now();
    await transaction(() async {
      await (update(menstrualCyclesTable)
            ..where((t) => t.donorProfileId.equals(donorProfileId) & t.isActive.equals(true)))
          .write(
        MenstrualCyclesTableCompanion(
          endDate: Value(resolvedEndDate),
          isActive: const Value(false),
        ),
      );if (recalculate != null) {
        await recalculate(donorProfileId);
      } });}
  Stream<List<MenstrualCyclesTableData>> watchCyclesForDonor(int donorProfileId) {
    return (select(menstrualCyclesTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId))
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
        .watch();}}
