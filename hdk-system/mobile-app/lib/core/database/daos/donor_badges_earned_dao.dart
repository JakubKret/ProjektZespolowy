import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/donor_badges_earned_table.dart';

part 'donor_badges_earned_dao.g.dart';

@DriftAccessor(tables: [DonorBadgesEarnedTable])
class DonorBadgesEarnedDao extends DatabaseAccessor<AppDatabase>
    with _$DonorBadgesEarnedDaoMixin {
  DonorBadgesEarnedDao(super.db);

  Future<int> awardBadge(DonorBadgesEarnedTableCompanion badge) {
    return into(donorBadgesEarnedTable).insert(badge);
  }

  Future<List<DonorBadgesEarnedTableData>> getEarnedBadgesForDonor(
    int donorProfileId,
  ) {
    return (select(donorBadgesEarnedTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId))
          ..orderBy([(t) => OrderingTerm.desc(t.earnedDate)]))
        .get();
  }

  Stream<List<DonorBadgesEarnedTableData>> watchEarnedBadgesForDonor(
    int donorProfileId,
  ) {
    return (select(donorBadgesEarnedTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId))
          ..orderBy([(t) => OrderingTerm.desc(t.earnedDate)]))
        .watch();
  }

  Future<int> deleteEarnedBadge(int id) {
    return (delete(donorBadgesEarnedTable)..where((t) => t.id.equals(id))).go();
  }
}
