import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/donor_profile_table.dart';
import 'tables/donations_table.dart';
import 'tables/menstrual_cycles.dart';
import 'tables/morphology_results_table.dart';
import 'tables/blood_centers_table.dart';
import 'tables/zhdk_badge_definitions_table.dart';
import 'tables/donor_badges_earned_table.dart';
import 'tables/notification_log_table.dart';
import 'tables/pit_annual_summary_table.dart';
import 'daos/blood_centers_dao.dart';
import 'daos/donor_badges_earned_dao.dart';
import 'daos/donor_profile_dao.dart';
import 'daos/donations_dao.dart';
import 'daos/menstrual_cycles_dao.dart';
import 'daos/morphology_results_dao.dart';
import 'daos/notification_log_dao.dart';
import 'daos/pit_annual_summary_dao.dart';
import 'daos/zhdk_badge_definitions_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    DonorProfileTable,
    DonationsTable,
    MenstrualCyclesTable,
    MorphologyResultsTable,
    BloodCentersTable,
    ZhdkBadgeDefinitionsTable,
    DonorBadgesEarnedTable,
    NotificationLogTable,
    PitAnnualSummaryTable,
  ],
  daos: [
    DonorProfileDao,
    DonationsDao,
    MenstrualCyclesDao,
    MorphologyResultsDao,
    BloodCentersDao,
    ZhdkBadgeDefinitionsDao,
    DonorBadgesEarnedDao,
    NotificationLogDao,
    PitAnnualSummaryDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  static AppDatabase? _instance;

  factory AppDatabase.instance() => _instance ??= AppDatabase();

  static Future<void> closeAndReset() async {
    await _instance?.close();
    _instance = null;
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await customStatement(
              'ALTER TABLE donor_profile ADD COLUMN email TEXT NOT NULL DEFAULT ""',
            );
            await customStatement(
              'ALTER TABLE donor_profile ADD COLUMN password_hash TEXT NOT NULL DEFAULT ""',
            );
          }
        },
      );

  static QueryExecutor _open() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'hdk.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
