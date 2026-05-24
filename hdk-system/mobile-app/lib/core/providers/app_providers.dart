import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../bootstrap/reference_data_seed.dart';
import '../database/app_database.dart';
import '../session/donor_display.dart';
import '../workflows/donor_workflow_service.dart';
import '../workflows/workflow_models.dart';

export '../database/app_database.dart' show AppDatabase;

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase.instance();
});

final donorWorkflowServiceProvider = Provider<DonorWorkflowService>((ref) {
  final db = ref.watch(databaseProvider);
  return DonorWorkflowService(db);
});

class CurrentDonorId extends Notifier<int?> {
  @override
  int? build() => null;

  void set(int id) => state = id;

  void clear() => state = null;
}

final currentDonorIdProvider =
    NotifierProvider<CurrentDonorId, int?>(CurrentDonorId.new);

final bloodCentersProvider = FutureProvider<List<BloodCentersTableData>>((
  ref,
) async {
  final db = ref.watch(databaseProvider);
  return db.bloodCentersDao.getAllCenters();
});

class DonorDashboardData {
  final DonorProfileTableData profile;
  final double totalLiters;
  final EligibilityStatus eligibility;

  const DonorDashboardData({
    required this.profile,
    required this.totalLiters,
    required this.eligibility,
  });

  String get bloodTypeLabel => formatBloodTypeLabel(profile);

  int get daysUntilNextDonation {
    if (eligibility.canDonate) return 0;
    final now = DateTime.now();
    final diff = eligibility.nextEligibleAt.difference(now);
    return diff.inDays < 0 ? 0 : diff.inDays + (diff.inHours % 24 > 0 ? 1 : 0);
  }

  String get nextDonationDateLabel =>
      DateFormat('dd.MM.yyyy').format(eligibility.nextEligibleAt);
}

final donorDashboardProvider = FutureProvider<DonorDashboardData?>((ref) async {
  final donorId = ref.watch(currentDonorIdProvider);
  if (donorId == null) return null;

  final db = ref.watch(databaseProvider);
  final workflow = ref.watch(donorWorkflowServiceProvider);

  final profile = await db.donorProfileDao.getProfileById(donorId);
  if (profile == null) return null;

  final volumeMl = await db.donationsDao.getAcceptedVolumeMlForDonor(donorId);
  final eligibility = await workflow.recalculateDonorEligibility(donorId);

  return DonorDashboardData(
    profile: profile,
    totalLiters: volumeMl / 1000.0,
    eligibility: eligibility,
  );
});

class BadgeDisplayItem {
  final ZhdkBadgeDefinitionsTableData definition;
  final bool isEarned;
  final DateTime? earnedDate;

  const BadgeDisplayItem({
    required this.definition,
    required this.isEarned,
    this.earnedDate,
  });

  String subtitleFor(DonorProfileTableData profile) {
    final threshold = profile.sex.toUpperCase() == 'F'
        ? definition.thresholdLitersFemale
        : definition.thresholdLitersMale;
    if (threshold == null) return definition.issuingBody;
    final liters = threshold.toStringAsFixed(0);
    return 'Próg: $liters L';
  }
}

class BenefitsData {
  final PitAnnualSummaryTableData? pitSummary;
  final List<BadgeDisplayItem> badges;

  const BenefitsData({required this.pitSummary, required this.badges});
}

final benefitsDataProvider = FutureProvider<BenefitsData?>((ref) async {
  final donorId = ref.watch(currentDonorIdProvider);
  if (donorId == null) return null;

  final db = ref.watch(databaseProvider);
  final workflow = ref.watch(donorWorkflowServiceProvider);
  final taxYear = DateTime.now().year;

  await workflow.recalculatePitForYear(
    donorProfileId: donorId,
    taxYear: taxYear,
    annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
  );

  final pitSummary = await db.pitAnnualSummaryDao.watchSummary(donorId, taxYear).first;
  final profile = await db.donorProfileDao.getProfileById(donorId);
  if (profile == null) return null;

  final definitions = await db.zhdkBadgeDefinitionsDao.getAllBadgeDefinitions();
  final earned = await db.donorBadgesEarnedDao.getEarnedBadgesForDonor(donorId);
  final earnedByBadgeId = {for (final e in earned) e.badgeId: e};

  final badges = definitions
      .map(
        (def) => BadgeDisplayItem(
          definition: def,
          isEarned: earnedByBadgeId.containsKey(def.id),
          earnedDate: earnedByBadgeId[def.id]?.earnedDate,
        ),
      )
      .toList();

  return BenefitsData(pitSummary: pitSummary, badges: badges);
});

final morphologyHistoryProvider =
    FutureProvider<List<MorphologyResultsTableData>>((ref) async {
      final donorId = ref.watch(currentDonorIdProvider);
      if (donorId == null) return [];

      final db = ref.watch(databaseProvider);
      return (db.select(db.morphologyResultsTable)
            ..where((t) => t.donorId.equals(donorId))
            ..orderBy([
              (t) => drift.OrderingTerm(
                expression: t.resultDate,
                mode: drift.OrderingMode.desc,
              ),
            ]))
          .get();
    });

final activeCycleProvider = FutureProvider<MenstrualCyclesTableData?>((ref) async {
  final donorId = ref.watch(currentDonorIdProvider);
  if (donorId == null) return null;

  final db = ref.watch(databaseProvider);
  final activeCycles =
      await (db.select(db.menstrualCyclesTable)
            ..where((t) => t.isActive.equals(true))
            ..where((t) => t.donorProfileId.equals(donorId)))
          .get();

  return activeCycles.isNotEmpty ? activeCycles.first : null;
});

void invalidateDonorData(WidgetRef ref) {
  ref.invalidate(donorDashboardProvider);
  ref.invalidate(benefitsDataProvider);
  ref.invalidate(morphologyHistoryProvider);
  ref.invalidate(activeCycleProvider);
  ref.invalidate(bloodCentersProvider);
}
