import 'package:drift/drift.dart';

class MenstrualCyclesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorProfileId => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (donor_profile_id) REFERENCES donor_profile(id) ON DELETE CASCADE',
      ];
}