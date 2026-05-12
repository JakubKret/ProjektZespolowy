import '../async_state.dart';
import '../dtos/donation_dtos.dart';
import '../dtos/donor_profile_dtos.dart';
import '../dtos/eligibility_dtos.dart';
import '../dtos/morphology_dtos.dart';
import '../dtos/notification_dtos.dart';

abstract class DonorUseCaseContract {
  Stream<AsyncState<DonorProfileResponse>> createDonorProfile(
    CreateDonorProfileRequest request,
  );

  Stream<AsyncState<RecordDonationResponse>> recordDonation(
    RecordDonationRequest request,
  );

  Stream<AsyncState<EligibilityResponse>> closeCycle(
    CloseCycleRequest request,
  );

  Stream<AsyncState<MorphologyRiskResponse>> saveMorphology(
    SaveMorphologyRequest request,
  );

  Stream<AsyncState<SendDueNotificationsResponse>> sendDueNotifications(
    SendDueNotificationsRequest request,
  );
}
