import 'package:drift/drift.dart';

class NotificationLogTable extends Table {
  @override
  String get tableName => 'notification_log';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorProfileId => integer()();
  TextColumn get notificationType => text()();
  DateTimeColumn get scheduledAt => dateTime()();
  DateTimeColumn get sentAt => dateTime().nullable()();
  BoolColumn get isDismissed =>
      boolean().withDefault(const Constant(false))();
  TextColumn get payloadJson => text().nullable()();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (donor_profile_id) REFERENCES donor_profile(id) ON DELETE CASCADE',
      ];
}
