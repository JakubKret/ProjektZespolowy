// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zhdk_badge_definitions_dao.dart';

// ignore_for_file: type=lint
mixin _$ZhdkBadgeDefinitionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ZhdkBadgeDefinitionsTableTable get zhdkBadgeDefinitionsTable =>
      attachedDatabase.zhdkBadgeDefinitionsTable;
  ZhdkBadgeDefinitionsDaoManager get managers =>
      ZhdkBadgeDefinitionsDaoManager(this);
}

class ZhdkBadgeDefinitionsDaoManager {
  final _$ZhdkBadgeDefinitionsDaoMixin _db;
  ZhdkBadgeDefinitionsDaoManager(this._db);
  $$ZhdkBadgeDefinitionsTableTableTableManager get zhdkBadgeDefinitionsTable =>
      $$ZhdkBadgeDefinitionsTableTableTableManager(
        _db.attachedDatabase,
        _db.zhdkBadgeDefinitionsTable,
      );
}
