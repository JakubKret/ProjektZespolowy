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
import 'daos/menstrual_cycles_dao.dart';
import 'daos/pit_annual_summary_dao.dart';

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
  daos: [MenstrualCyclesDao, PitAnnualSummaryDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _open() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'hdk.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
