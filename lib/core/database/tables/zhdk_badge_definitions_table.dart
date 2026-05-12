import 'package:drift/drift.dart';

class ZhdkBadgeDefinitionsTable extends Table {
  @override
  String get tableName => 'zhdk_badge_definitions';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get badgeCode => text().unique()();
  TextColumn get name => text()();
  RealColumn get thresholdLitersMale => real().nullable()();
  RealColumn get thresholdLitersFemale => real().nullable()();
  TextColumn get issuingBody => text()();
  TextColumn get privilegesJson => text().nullable()();
}
