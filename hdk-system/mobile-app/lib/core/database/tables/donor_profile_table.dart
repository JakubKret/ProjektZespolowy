import 'package:drift/drift.dart';

class DonorProfileTable extends Table {
  @override
  String get tableName => 'donor_profile';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  DateTimeColumn get birthDate => dateTime()();
  TextColumn get sex => text()();
  TextColumn get bloodType => text().nullable()();
  TextColumn get rhFactor => text().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
