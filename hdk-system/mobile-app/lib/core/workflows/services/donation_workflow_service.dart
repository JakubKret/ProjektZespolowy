import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../workflow_models.dart';
import 'badge_workflow_service.dart';
import 'notification_workflow_service.dart';
import 'pit_workflow_service.dart';

class DonationWorkflowService {
  final AppDatabase _db;
  final BadgeWorkflowService _badgeWorkflow;
  final PitWorkflowService _pitWorkflow;
  final NotificationWorkflowService _notificationWorkflow;

  DonationWorkflowService(
    this._db,
    this._badgeWorkflow,
    this._pitWorkflow,
    this._notificationWorkflow,
  );

  Future<DonationWorkflowResult> recordDonationAndRefreshBenefits({
    required int donorProfileId,
    required int bloodCenterId,
    required DateTime donationDate,
    required int volumeMl,
    required double annualIncomePln,
    String donationType = 'whole_blood',
    double otherDonationsPln = 0.0,
    int? taxYear,
  }) async {
    return _db.transaction(() async {
      final donationId = await _db.donationsDao.createDonation(
        DonationsTableCompanion.insert(
          donorProfileId: donorProfileId,
          bloodCenterId: bloodCenterId,
          donationType: donationType,
          donationDate: donationDate,
          volumeMl: volumeMl,
        ),
      );

      final pitSummary = await _pitWorkflow.recalculatePitForYear(
        donorProfileId: donorProfileId,
        taxYear: taxYear ?? donationDate.year,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

      final awardedBadgeIds = await _badgeWorkflow.evaluateAndAwardBadges(
        donorProfileId: donorProfileId,
        earnedDate: donationDate,
      );

      final notificationId = awardedBadgeIds.isEmpty
          ? null
          : await _notificationWorkflow.createBadgeNotification(
              donorProfileId: donorProfileId,
              awardedBadgeIds: awardedBadgeIds,
              donationId: donationId,
            );

      return DonationWorkflowResult(
        donationId: donationId,
        pitNetDeductionPln: pitSummary.netDeductionPln,
        awardedBadgeIds: awardedBadgeIds,
        notificationId: notificationId,
      );
    });
  }

  Future<DonationWorkflowResult> editDonationAndRecompute({
    required int donationId,
    DateTime? donationDate,
    int? volumeMl,
    bool? isRejected,
    String? rejectionReason,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) async {
    return _db.transaction(() async {
      final donation = await _db.donationsDao.getDonationById(donationId);
      if (donation == null) {
        throw StateError('Donation not found: $donationId');
      }

      final newDonationDate = donationDate ?? donation.donationDate;
      await (_db.update(_db.donationsTable)..where((t) => t.id.equals(donationId))).write(
        DonationsTableCompanion(
          donationDate: Value(newDonationDate),
          volumeMl: Value(volumeMl ?? donation.volumeMl),
          isRejected: Value(isRejected ?? donation.isRejected),
          rejectionReason: Value(rejectionReason ?? donation.rejectionReason),
        ),
      );

      final pitSummary = await _pitWorkflow.recalculatePitForYear(
        donorProfileId: donation.donorProfileId,
        taxYear: newDonationDate.year,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

      final awardedBadgeIds = await _badgeWorkflow.evaluateAndAwardBadges(
        donorProfileId: donation.donorProfileId,
        earnedDate: newDonationDate,
      );

      final notificationId = awardedBadgeIds.isEmpty
          ? null
          : await _notificationWorkflow.createBadgeNotification(
              donorProfileId: donation.donorProfileId,
              awardedBadgeIds: awardedBadgeIds,
              donationId: donationId,
            );

      return DonationWorkflowResult(
        donationId: donationId,
        pitNetDeductionPln: pitSummary.netDeductionPln,
        awardedBadgeIds: awardedBadgeIds,
        notificationId: notificationId,
      );
    });
  }

  Future<void> deleteDonationAndRecompute({
    required int donationId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) async {
    await _db.transaction(() async {
      final donation = await _db.donationsDao.getDonationById(donationId);
      if (donation == null) {
        return;
      }
      await _db.donationsDao.deleteDonation(donationId);
      await _pitWorkflow.recalculatePitForYear(
        donorProfileId: donation.donorProfileId,
        taxYear: donation.donationDate.year,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );
    });
  }

  Future<void> markDonationRejected({
    required int donationId,
    String? rejectionReason,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) async {
    final donation = await _db.donationsDao.getDonationById(donationId);
    if (donation == null) {
      return;
    }
    await editDonationAndRecompute(
      donationId: donationId,
      isRejected: true,
      rejectionReason: rejectionReason,
      annualIncomePln: annualIncomePln,
      otherDonationsPln: otherDonationsPln,
    );
  }

  Future<void> clearDonationRejection({
    required int donationId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) async {
    final donation = await _db.donationsDao.getDonationById(donationId);
    if (donation == null) {
      return;
    }
    await editDonationAndRecompute(
      donationId: donationId,
      isRejected: false,
      rejectionReason: null,
      annualIncomePln: annualIncomePln,
      otherDonationsPln: otherDonationsPln,
    );
  }
}
