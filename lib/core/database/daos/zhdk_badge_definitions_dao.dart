import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/zhdk_badge_definitions_table.dart';

part 'zhdk_badge_definitions_dao.g.dart';

@DriftAccessor(tables: [ZhdkBadgeDefinitionsTable])
class ZhdkBadgeDefinitionsDao extends DatabaseAccessor<AppDatabase>
    with _$ZhdkBadgeDefinitionsDaoMixin {
  ZhdkBadgeDefinitionsDao(super.db);

  Future<int> createBadgeDefinition(ZhdkBadgeDefinitionsTableCompanion badge) {
    return into(zhdkBadgeDefinitionsTable).insert(badge);
  }

  Future<ZhdkBadgeDefinitionsTableData?> getByBadgeCode(String badgeCode) {
    return (select(zhdkBadgeDefinitionsTable)
          ..where((t) => t.badgeCode.equals(badgeCode)))
        .getSingleOrNull();
  }

  Future<List<ZhdkBadgeDefinitionsTableData>> getAllBadgeDefinitions() {
    return (select(zhdkBadgeDefinitionsTable)
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  Stream<List<ZhdkBadgeDefinitionsTableData>> watchAllBadgeDefinitions() {
    return (select(zhdkBadgeDefinitionsTable)
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .watch();
  }

  Future<bool> updateBadgeDefinition(ZhdkBadgeDefinitionsTableData badge) {
    return update(zhdkBadgeDefinitionsTable).replace(badge);
  }

  Future<int> deleteBadgeDefinition(int id) {
    return (delete(zhdkBadgeDefinitionsTable)..where((t) => t.id.equals(id))).go();
  }
}
