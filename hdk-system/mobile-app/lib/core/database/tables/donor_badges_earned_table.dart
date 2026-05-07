import 'package:drift/drift.dart';

class DonorBadgesEarnedTable extends Table {
  @override
  String get tableName => 'donor_badges_earned';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorProfileId => integer()();
  IntColumn get badgeId => integer()();
  DateTimeColumn get earnedDate => dateTime()();
  RealColumn get totalLitersAtEarn => real()();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (donor_profile_id) REFERENCES donor_profile(id) ON DELETE CASCADE',
        'FOREIGN KEY (badge_id) REFERENCES zhdk_badge_definitions(id) ON DELETE RESTRICT',
      ];
}
