// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donor_badges_earned_dao.dart';

// ignore_for_file: type=lint
mixin _$DonorBadgesEarnedDaoMixin on DatabaseAccessor<AppDatabase> {
  $DonorBadgesEarnedTableTable get donorBadgesEarnedTable =>
      attachedDatabase.donorBadgesEarnedTable;
  DonorBadgesEarnedDaoManager get managers => DonorBadgesEarnedDaoManager(this);
}

class DonorBadgesEarnedDaoManager {
  final _$DonorBadgesEarnedDaoMixin _db;
  DonorBadgesEarnedDaoManager(this._db);
  $$DonorBadgesEarnedTableTableTableManager get donorBadgesEarnedTable =>
      $$DonorBadgesEarnedTableTableTableManager(
        _db.attachedDatabase,
        _db.donorBadgesEarnedTable,
      );
}
