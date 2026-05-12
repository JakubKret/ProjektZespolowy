import '../contracts/app_error.dart';
import '../contracts/async_state.dart';
import '../contracts/dtos/donation_dtos.dart';
import '../contracts/dtos/donor_profile_dtos.dart';
import '../contracts/dtos/eligibility_dtos.dart';
import '../contracts/dtos/morphology_dtos.dart';
import '../contracts/dtos/notification_dtos.dart';
import '../contracts/use_cases/donor_use_case_contract.dart';
import '../workflows/donor_workflow_service.dart';

class DriftDonorUseCase implements DonorUseCaseContract {
  final DonorWorkflowService _workflow;

  DriftDonorUseCase(this._workflow);

  @override
  Stream<AsyncState<DonorProfileResponse>> createDonorProfile(
    CreateDonorProfileRequest request,
  ) {
    return _run(() async {
      final donorId = await _workflow.createDonorProfile(
        firstName: request.firstName,
        lastName: request.lastName,
        birthDate: request.birthDate,
        sex: request.sex,
        bloodType: request.bloodType,
        rhFactor: request.rhFactor,
      );
      return DonorProfileResponse(donorProfileId: donorId);
    });
  }

  @override
  Stream<AsyncState<RecordDonationResponse>> recordDonation(
    RecordDonationRequest request,
  ) {
    return _run(() async {
      final result = await _workflow.recordDonationAndRefreshBenefits(
        donorProfileId: request.donorProfileId,
        bloodCenterId: request.bloodCenterId,
        donationDate: request.donationDate,
        volumeMl: request.volumeMl,
        annualIncomePln: request.annualIncomePln,
        donationType: request.donationType,
        otherDonationsPln: request.otherDonationsPln,
        taxYear: request.taxYear,
      );

      return RecordDonationResponse(
        donationId: result.donationId,
        pitNetDeductionPln: result.pitNetDeductionPln,
        awardedBadgeIds: result.awardedBadgeIds,
        notificationId: result.notificationId,
      );
    });
  }

  @override
  Stream<AsyncState<EligibilityResponse>> closeCycle(CloseCycleRequest request) {
    return _run(() async {
      final result = await _workflow.closeCycleAndRecomputeEligibility(
        donorProfileId: request.donorProfileId,
        endDate: request.endDate,
      );

      return EligibilityResponse(
        canDonate: result.canDonate,
        nextEligibleAt: result.nextEligibleAt,
        reason: result.reason,
      );
    });
  }

  @override
  Stream<AsyncState<MorphologyRiskResponse>> saveMorphology(
    SaveMorphologyRequest request,
  ) {
    return _run(() async {
      final result = await _workflow.saveMorphologyResultAndEvaluateRisk(
        donorProfileId: request.donorProfileId,
        resultDate: request.resultDate,
        donationId: request.donationId,
        hgbGDl: request.hgbGDl,
        ferritinNgMl: request.ferritinNgMl,
        isVerified: request.isVerified,
      );

      return MorphologyRiskResponse(
        morphologyResultId: result.morphologyResultId,
        isRiskDetected: result.isRiskDetected,
        notificationId: result.notificationId,
      );
    });
  }

  @override
  Stream<AsyncState<SendDueNotificationsResponse>> sendDueNotifications(
    SendDueNotificationsRequest request,
  ) {
    return _run(() async {
      final result = await _workflow.sendDueNotifications(asOf: request.asOf);
      return SendDueNotificationsResponse(
        sentCount: result.sentCount,
        sentNotificationIds: result.sentNotificationIds,
      );
    });
  }

  Stream<AsyncState<T>> _run<T>(Future<T> Function() operation) async* {
    yield const AsyncState.loading();
    try {
      final data = await operation();
      yield AsyncState.success(data);
    } on StateError catch (e) {
      yield AsyncState.failure(
        AppError(type: AppErrorType.notFound, message: e.message, cause: e),
      );
    } on ArgumentError catch (e) {
      yield AsyncState.failure(
        AppError(
          type: AppErrorType.validation,
          message: e.message.toString(),
          cause: e,
        ),
      );
    } catch (e) {
      yield AsyncState.failure(
        AppError(
          type: AppErrorType.unexpected,
          message: 'Unexpected error while executing use case.',
          cause: e,
        ),
      );
    }
  }
}
