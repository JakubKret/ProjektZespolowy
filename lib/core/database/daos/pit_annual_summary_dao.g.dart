// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pit_annual_summary_dao.dart';

// ignore_for_file: type=lint
mixin _$PitAnnualSummaryDaoMixin on DatabaseAccessor<AppDatabase> {
  $DonationsTableTable get donationsTable => attachedDatabase.donationsTable;
  $PitAnnualSummaryTableTable get pitAnnualSummaryTable =>
      attachedDatabase.pitAnnualSummaryTable;
  PitAnnualSummaryDaoManager get managers => PitAnnualSummaryDaoManager(this);
}

class PitAnnualSummaryDaoManager {
  final _$PitAnnualSummaryDaoMixin _db;
  PitAnnualSummaryDaoManager(this._db);
  $$DonationsTableTableTableManager get donationsTable =>
      $$DonationsTableTableTableManager(
        _db.attachedDatabase,
        _db.donationsTable,
      );
  $$PitAnnualSummaryTableTableTableManager get pitAnnualSummaryTable =>
      $$PitAnnualSummaryTableTableTableManager(
        _db.attachedDatabase,
        _db.pitAnnualSummaryTable,
      );
}
