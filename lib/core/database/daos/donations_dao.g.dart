// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donations_dao.dart';

// ignore_for_file: type=lint
mixin _$DonationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DonationsTableTable get donationsTable => attachedDatabase.donationsTable;
  DonationsDaoManager get managers => DonationsDaoManager(this);
}

class DonationsDaoManager {
  final _$DonationsDaoMixin _db;
  DonationsDaoManager(this._db);
  $$DonationsTableTableTableManager get donationsTable =>
      $$DonationsTableTableTableManager(
        _db.attachedDatabase,
        _db.donationsTable,
      );
}
