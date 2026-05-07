import 'package:drift/drift.dart';

class MorphologyResultsTable extends Table {
  @override
  String get tableName => 'morphology_results';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorId => integer()();
  IntColumn get donationId => integer().nullable()();
  DateTimeColumn get resultDate => dateTime()();
  TextColumn get imagePath => text().nullable()();
  RealColumn get ocrConfidence => real().nullable()();
  BoolColumn get isVerified =>
      boolean().withDefault(const Constant(false))();

  // Red blood cell parameters
  RealColumn get hgbGDl => real().nullable()();
  RealColumn get hctPct => real().nullable()();
  RealColumn get rbcMlnUl => real().nullable()();
  RealColumn get mcvFl => real().nullable()();
  RealColumn get mchPg => real().nullable()();
  RealColumn get mchcGDl => real().nullable()();
  RealColumn get rdwPct => real().nullable()();

  // White blood cell parameters
  RealColumn get wbcTysUl => real().nullable()();
  RealColumn get neutPct => real().nullable()();
  RealColumn get lymphPct => real().nullable()();
  RealColumn get monoPct => real().nullable()();
  RealColumn get eosPct => real().nullable()();
  RealColumn get basoPct => real().nullable()();

  // Platelet parameters
  RealColumn get pltTysUl => real().nullable()();
  RealColumn get mpvFl => real().nullable()();

  // Iron parameters
  RealColumn get feUgDl => real().nullable()();
  RealColumn get ferritinNgMl => real().nullable()();

  TextColumn get labName => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (donor_id) REFERENCES donor_profile(id) ON DELETE CASCADE',
        'FOREIGN KEY (donation_id) REFERENCES donations(id) ON DELETE SET NULL',
      ];
}
