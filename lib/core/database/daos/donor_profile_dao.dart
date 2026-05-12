import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/donor_profile_table.dart';

part 'donor_profile_dao.g.dart';

@DriftAccessor(tables: [DonorProfileTable])
class DonorProfileDao extends DatabaseAccessor<AppDatabase>
    with _$DonorProfileDaoMixin {
  DonorProfileDao(super.db);

  Future<int> createProfile(DonorProfileTableCompanion profile) {
    return into(donorProfileTable).insert(profile);
  }

  Future<DonorProfileTableData?> getProfileById(int id) {
    return (select(donorProfileTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<DonorProfileTableData?> watchProfileById(int id) {
    return (select(donorProfileTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<List<DonorProfileTableData>> getAllProfiles() {
    return (select(donorProfileTable)
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Future<bool> updateProfile(DonorProfileTableData profile) {
    return update(donorProfileTable).replace(profile);
  }

  Future<int> deleteProfile(int id) {
    return (delete(donorProfileTable)..where((t) => t.id.equals(id))).go();
  }
}
