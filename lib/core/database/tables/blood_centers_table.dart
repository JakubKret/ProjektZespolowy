import 'package:drift/drift.dart';

class BloodCentersTable extends Table {
  @override
  String get tableName => 'blood_centers';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get city => text()();
  TextColumn get address => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get isMobile =>
      boolean().withDefault(const Constant(false))();
  TextColumn get phone => text().nullable()();
  TextColumn get operatingHoursJson => text().nullable()();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
}
