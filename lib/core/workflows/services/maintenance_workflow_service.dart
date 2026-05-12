import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import 'badge_workflow_service.dart';
import 'eligibility_workflow_service.dart';
import 'notification_workflow_service.dart';
import 'pit_workflow_service.dart';

class MaintenanceWorkflowService {
  final AppDatabase _db;
  final PitWorkflowService _pitWorkflow;
  final BadgeWorkflowService _badgeWorkflow;
  final EligibilityWorkflowService _eligibilityWorkflow;
  final NotificationWorkflowService _notificationWorkflow;

  MaintenanceWorkflowService(
    this._db,
    this._pitWorkflow,
    this._badgeWorkflow,
    this._eligibilityWorkflow,
    this._notificationWorkflow,
  );

  Future<void> backfillDerivedDataForDonor({
    required int donorProfileId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) async {
    await _db.transaction(() async {
      await _pitWorkflow.recalculateAllPitYearsForDonor(
        donorProfileId: donorProfileId,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );
      await _badgeWorkflow.evaluateAndAwardBadges(
        donorProfileId: donorProfileId,
        earnedDate: DateTime.now(),
      );
      final status = await _eligibilityWorkflow.recalculateDonorEligibility(donorProfileId);
      await _notificationWorkflow.scheduleEligibilityNotifications(
        donorProfileId: donorProfileId,
        nextEligibleAt: status.nextEligibleAt,
        reason: status.reason,
      );
    });
  }

  Future<void> consistencyCheckAndRepair(int donorProfileId) async {
    await _db.transaction(() async {
      final cycles = await _db.menstrualCyclesDao.watchCyclesForDonor(donorProfileId).first;
      final activeCycles = cycles.where((c) => c.isActive).toList();
      if (activeCycles.length > 1) {
        final latest = activeCycles.reduce(
          (a, b) => a.startDate.isAfter(b.startDate) ? a : b,
        );
        for (final cycle in activeCycles.where((c) => c.id != latest.id)) {
          await (_db.update(_db.menstrualCyclesTable)..where((t) => t.id.equals(cycle.id)))
              .write(
            const MenstrualCyclesTableCompanion(isActive: Value(false)),
          );
        }
      }
    });
  }
}
