import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/blood_centers_table.dart';

part 'blood_centers_dao.g.dart';

@DriftAccessor(tables: [BloodCentersTable])
class BloodCentersDao extends DatabaseAccessor<AppDatabase>
    with _$BloodCentersDaoMixin {
  BloodCentersDao(super.db);

  Future<int> createCenter(BloodCentersTableCompanion center) {
    return into(bloodCentersTable).insert(center);
  }

  Future<BloodCentersTableData?> getCenterById(int id) {
    return (select(bloodCentersTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<BloodCentersTableData>> getAllCenters() {
    return (select(bloodCentersTable)
          ..orderBy([(t) => OrderingTerm.asc(t.city), (t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Stream<List<BloodCentersTableData>> watchAllCenters() {
    return (select(bloodCentersTable)
          ..orderBy([(t) => OrderingTerm.asc(t.city), (t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  Future<bool> updateCenter(BloodCentersTableData center) {
    return update(bloodCentersTable).replace(center);
  }

  Future<int> deleteCenter(int id) {
    return (delete(bloodCentersTable)..where((t) => t.id.equals(id))).go();
  }
}
