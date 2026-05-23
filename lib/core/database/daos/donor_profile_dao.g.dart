// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_profile_dao.dart';

// ignore_for_file: type=lint
mixin _$DonorProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $DonorProfileTableTable get donorProfileTable =>
      attachedDatabase.donorProfileTable;
  DonorProfileDaoManager get managers => DonorProfileDaoManager(this);
}

class DonorProfileDaoManager {
  final _$DonorProfileDaoMixin _db;
  DonorProfileDaoManager(this._db);
  $$DonorProfileTableTableTableManager get donorProfileTable =>
      $$DonorProfileTableTableTableManager(
        _db.attachedDatabase,
        _db.donorProfileTable,
      );
}
