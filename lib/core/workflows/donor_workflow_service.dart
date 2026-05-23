import '../database/app_database.dart';
import 'services/badge_workflow_service.dart';
import 'services/donation_workflow_service.dart';
import 'services/donor_profile_workflow_service.dart';
import 'services/eligibility_workflow_service.dart';
import 'services/maintenance_workflow_service.dart';
import 'services/morphology_workflow_service.dart';
import 'services/notification_workflow_service.dart';
import 'services/pit_workflow_service.dart';
import 'services/reference_data_workflow_service.dart';
import 'workflow_models.dart';

class DonorWorkflowService {
  late final DonorProfileWorkflowService _donorProfile;
  late final BadgeWorkflowService _badge;
  late final PitWorkflowService _pit;
  late final NotificationWorkflowService _notification;
  late final DonationWorkflowService _donation;
  late final EligibilityWorkflowService _eligibility;
  late final MorphologyWorkflowService _morphology;
  late final ReferenceDataWorkflowService _referenceData;
  late final MaintenanceWorkflowService _maintenance;

  DonorWorkflowService(AppDatabase db) {
    _donorProfile = DonorProfileWorkflowService(db);
    _badge = BadgeWorkflowService(db);
    _pit = PitWorkflowService(db);
    _notification = NotificationWorkflowService(db);
    _donation = DonationWorkflowService(db, _badge, _pit, _notification);
    _eligibility = EligibilityWorkflowService(db, _notification);
    _morphology = MorphologyWorkflowService(db, _notification);
    _referenceData = ReferenceDataWorkflowService(db);
    _maintenance = MaintenanceWorkflowService(
      db,
      _pit,
      _badge,
      _eligibility,
      _notification,
    );
  }

  Future<int> createDonorProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String sex,
    String? bloodType,
    String? rhFactor,
  }) {
    return _donorProfile.createDonorProfile(
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      sex: sex,
      bloodType: bloodType,
      rhFactor: rhFactor,
    );
  }

  Future<bool> updateDonorProfile({
    required int donorProfileId,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    String? sex,
    String? bloodType,
    String? rhFactor,
  }) => _donorProfile.updateDonorProfile(
        donorProfileId: donorProfileId,
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        sex: sex,
        bloodType: bloodType,
        rhFactor: rhFactor,
      );

  Future<int> deleteDonorProfile(int donorProfileId) =>
      _donorProfile.deleteDonorProfile(donorProfileId);

  Future<DonationWorkflowResult> recordDonationAndRefreshBenefits({
    required int donorProfileId,
    required int bloodCenterId,
    required DateTime donationDate,
    required int volumeMl,
    required double annualIncomePln,
    String donationType = 'whole_blood',
    double otherDonationsPln = 0.0,
    int? taxYear,
  }) => _donation.recordDonationAndRefreshBenefits(
        donorProfileId: donorProfileId,
        bloodCenterId: bloodCenterId,
        donationDate: donationDate,
        volumeMl: volumeMl,
        annualIncomePln: annualIncomePln,
        donationType: donationType,
        otherDonationsPln: otherDonationsPln,
        taxYear: taxYear,
      );

  Future<DonationWorkflowResult> editDonationAndRecompute({
    required int donationId,
    DateTime? donationDate,
    int? volumeMl,
    bool? isRejected,
    String? rejectionReason,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) => _donation.editDonationAndRecompute(
        donationId: donationId,
        donationDate: donationDate,
        volumeMl: volumeMl,
        isRejected: isRejected,
        rejectionReason: rejectionReason,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

  Future<void> deleteDonationAndRecompute({
    required int donationId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) => _donation.deleteDonationAndRecompute(
        donationId: donationId,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

  Future<void> markDonationRejected({
    required int donationId,
    String? rejectionReason,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) => _donation.markDonationRejected(
        donationId: donationId,
        rejectionReason: rejectionReason,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

  Future<void> clearDonationRejection({
    required int donationId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) => _donation.clearDonationRejection(
        donationId: donationId,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

  Future<int> startCycle({
    required int donorProfileId,
    required DateTime startDate,
  }) => _eligibility.startCycle(
        donorProfileId: donorProfileId,
        startDate: startDate,
      );

  Future<EligibilityStatus> closeCycleAndRecomputeEligibility({
    required int donorProfileId,
    DateTime? endDate,
  }) => _eligibility.closeCycleAndRecomputeEligibility(
        donorProfileId: donorProfileId,
        endDate: endDate,
      );

  Future<EligibilityStatus> recalculateDonorEligibility(int donorProfileId) =>
      _eligibility.recalculateDonorEligibility(donorProfileId);

  Future<MorphologyRiskResult> saveMorphologyResultAndEvaluateRisk({
    required int donorProfileId,
    required DateTime resultDate,
    int? donationId,
    double? hgbGDl,
    double? ferritinNgMl,
    bool isVerified = false,
  }) => _morphology.saveMorphologyResultAndEvaluateRisk(
        donorProfileId: donorProfileId,
        resultDate: resultDate,
        donationId: donationId,
        hgbGDl: hgbGDl,
        ferritinNgMl: ferritinNgMl,
        isVerified: isVerified,
      );

  Future<int> verifyMorphologyResult(int morphologyResultId) =>
      _morphology.verifyMorphologyResult(morphologyResultId);

  Future<int> linkMorphologyToDonation({
    required int morphologyResultId,
    required int donationId,
  }) => _morphology.linkMorphologyToDonation(
        morphologyResultId: morphologyResultId,
        donationId: donationId,
      );

  Future<List<int>> evaluateAndAwardBadges({
    required int donorProfileId,
    required DateTime earnedDate,
  }) => _badge.evaluateAndAwardBadges(
        donorProfileId: donorProfileId,
        earnedDate: earnedDate,
      );

  Future<PitAnnualSummaryTableData> recalculatePitForYear({
    required int donorProfileId,
    required int taxYear,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) => _pit.recalculatePitForYear(
        donorProfileId: donorProfileId,
        taxYear: taxYear,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

  Future<List<PitAnnualSummaryTableData>> recalculateAllPitYearsForDonor({
    required int donorProfileId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) => _pit.recalculateAllPitYearsForDonor(
        donorProfileId: donorProfileId,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

  Future<int> scheduleEligibilityNotifications({
    required int donorProfileId,
    required DateTime nextEligibleAt,
    required String reason,
  }) => _notification.scheduleEligibilityNotifications(
        donorProfileId: donorProfileId,
        nextEligibleAt: nextEligibleAt,
        reason: reason,
      );

  Future<SentNotificationsResult> sendDueNotifications({DateTime? asOf}) =>
      _notification.sendDueNotifications(asOf: asOf);

  Future<int> dismissNotification(int notificationId) =>
      _notification.dismissNotification(notificationId);

  Future<int> rescheduleNotification({
    required int notificationId,
    required DateTime scheduledAt,
  }) => _notification.rescheduleNotification(
        notificationId: notificationId,
        scheduledAt: scheduledAt,
      );

  Future<void> syncBloodCenters(List<BloodCenterSyncInput> centers) =>
      _referenceData.syncBloodCenters(centers);

  Future<void> syncBadgeDefinitions(List<BadgeDefinitionSyncInput> badges) =>
      _badge.syncBadgeDefinitions(badges);

  Future<void> backfillDerivedDataForDonor({
    required int donorProfileId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) => _maintenance.backfillDerivedDataForDonor(
        donorProfileId: donorProfileId,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );

  Future<void> consistencyCheckAndRepair(int donorProfileId) =>
      _maintenance.consistencyCheckAndRepair(donorProfileId);
}
