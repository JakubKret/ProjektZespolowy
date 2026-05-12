import 'package:drift/drift.dart';

class DonationsTable extends Table {
  @override
  String get tableName => 'donations';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorProfileId => integer()();
  IntColumn get bloodCenterId => integer()();
  TextColumn get donationType => text()(); 
  DateTimeColumn get donationDate => dateTime()();
  IntColumn get volumeMl => integer().check(volumeMl.isBiggerThanValue(0))();
  BoolColumn get isRejected => boolean().withDefault(const Constant(false))();
  TextColumn get rejectionReason => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (donor_profile_id) REFERENCES donor_profile(id) ON DELETE CASCADE',
        'FOREIGN KEY (blood_center_id) REFERENCES blood_centers(id) ON DELETE RESTRICT',
      ];
}