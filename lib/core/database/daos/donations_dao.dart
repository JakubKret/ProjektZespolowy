import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/donations_table.dart';

part 'donations_dao.g.dart';

@DriftAccessor(tables: [DonationsTable])
class DonationsDao extends DatabaseAccessor<AppDatabase> with _$DonationsDaoMixin {
  DonationsDao(super.db);

  Future<int> createDonation(DonationsTableCompanion donation) {
    return into(donationsTable).insert(donation);
  }

  Future<DonationsTableData?> getDonationById(int id) {
    return (select(donationsTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<DonationsTableData>> getDonationsForDonor(int donorProfileId) {
    return (select(donationsTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId))
          ..orderBy([(t) => OrderingTerm.desc(t.donationDate)]))
        .get();
  }

  Stream<List<DonationsTableData>> watchDonationsForDonor(int donorProfileId) {
    return (select(donationsTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId))
          ..orderBy([(t) => OrderingTerm.desc(t.donationDate)]))
        .watch();
  }

  Future<int> getAcceptedVolumeMlForDonor(int donorProfileId) async {
    final volumeSumExpr = donationsTable.volumeMl.sum();
    final row =
        await (selectOnly(donationsTable)
              ..addColumns([volumeSumExpr])
              ..where(
                donationsTable.donorProfileId.equals(donorProfileId) &
                    donationsTable.isRejected.equals(false),
              ))
            .getSingle();
    return row.read(volumeSumExpr) ?? 0;
  }

  Future<int> deleteDonation(int id) {
    return (delete(donationsTable)..where((t) => t.id.equals(id))).go();
  }
}
