import '../../database/app_database.dart';
import '../workflow_models.dart';
import 'notification_workflow_service.dart';

class EligibilityWorkflowService {
  final AppDatabase _db;
  final NotificationWorkflowService _notificationWorkflow;

  EligibilityWorkflowService(this._db, this._notificationWorkflow);

  Future<int> startCycle({
    required int donorProfileId,
    required DateTime startDate,
  }) {
    return _db.menstrualCyclesDao.createCycleAndRecalculate(
      MenstrualCyclesTableCompanion.insert(
        donorProfileId: donorProfileId,
        startDate: startDate,
      ),
    );
  }

  Future<EligibilityStatus> closeCycleAndRecomputeEligibility({
    required int donorProfileId,
    DateTime? endDate,
  }) async {
    await _db.menstrualCyclesDao.closeActiveCycle(donorProfileId, endDate: endDate);
    final status = await recalculateDonorEligibility(donorProfileId);
    await _notificationWorkflow.scheduleEligibilityNotifications(
      donorProfileId: donorProfileId,
      nextEligibleAt: status.nextEligibleAt,
      reason: status.reason,
    );
    return status;
  }

  Future<EligibilityStatus> recalculateDonorEligibility(int donorProfileId) async {
    final donations = await _db.donationsDao.getDonationsForDonor(donorProfileId);
    final latestDonationDate = donations.isEmpty ? null : donations.first.donationDate;

    final morphology = await _db.morphologyResultsDao.getResultsForDonor(donorProfileId);
    final hasLowHemoglobin = morphology.any((r) => (r.hgbGDl ?? 99) < 12.0);

    final now = DateTime.now();
    var nextEligibleAt = latestDonationDate == null
        ? now
        : latestDonationDate.add(const Duration(days: 56));
    var canDonate = !nextEligibleAt.isAfter(now);
    var reason = canDonate ? 'eligible' : 'recent_donation_wait';

    if (hasLowHemoglobin) {
      final morphologyWait = now.add(const Duration(days: 30));
      if (morphologyWait.isAfter(nextEligibleAt)) {
        nextEligibleAt = morphologyWait;
      }
      canDonate = false;
      reason = 'low_hemoglobin';
    }

    return EligibilityStatus(
      canDonate: canDonate,
      nextEligibleAt: nextEligibleAt,
      reason: reason,
    );
  }
}
