class CloseCycleRequest {
  final int donorProfileId;
  final DateTime? endDate;

  const CloseCycleRequest({
    required this.donorProfileId,
    this.endDate,
  });
}

class EligibilityResponse {
  final bool canDonate;
  final DateTime nextEligibleAt;
  final String reason;

  const EligibilityResponse({
    required this.canDonate,
    required this.nextEligibleAt,
    required this.reason,
  });
}
