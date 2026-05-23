// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_centers_dao.dart';

// ignore_for_file: type=lint
mixin _$BloodCentersDaoMixin on DatabaseAccessor<AppDatabase> {
  $BloodCentersTableTable get bloodCentersTable =>
      attachedDatabase.bloodCentersTable;
  BloodCentersDaoManager get managers => BloodCentersDaoManager(this);
}

class BloodCentersDaoManager {
  final _$BloodCentersDaoMixin _db;
  BloodCentersDaoManager(this._db);
  $$BloodCentersTableTableTableManager get bloodCentersTable =>
      $$BloodCentersTableTableTableManager(
        _db.attachedDatabase,
        _db.bloodCentersTable,
      );
}
