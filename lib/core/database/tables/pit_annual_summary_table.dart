import 'package:drift/drift.dart';

class PitAnnualSummaryTable extends Table {
  @override
  String get tableName => 'pit_annual_summary';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorProfileId => integer()();
  IntColumn get taxYear => integer()();
  IntColumn get totalVolumeMl => integer()();
  RealColumn get ratePlnPerLiter => real()();
  RealColumn get grossDeductionPln => real()();
  RealColumn get income6PctCap => real()();
  RealColumn get netDeductionPln => real()();
  DateTimeColumn get lastCalculatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (donor_profile_id) REFERENCES donor_profile(id) ON DELETE CASCADE',
        'UNIQUE (donor_profile_id, tax_year)',
      ];
}
