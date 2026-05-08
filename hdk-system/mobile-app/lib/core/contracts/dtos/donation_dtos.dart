class RecordDonationRequest {
  final int donorProfileId;
  final int bloodCenterId;
  final DateTime donationDate;
  final int volumeMl;
  final double annualIncomePln;
  final String donationType;
  final double otherDonationsPln;
  final int? taxYear;

  const RecordDonationRequest({
    required this.donorProfileId,
    required this.bloodCenterId,
    required this.donationDate,
    required this.volumeMl,
    required this.annualIncomePln,
    this.donationType = 'whole_blood',
    this.otherDonationsPln = 0.0,
    this.taxYear,
  });
}

class RecordDonationResponse {
  final int donationId;
  final double pitNetDeductionPln;
  final List<int> awardedBadgeIds;
  final int? notificationId;

  const RecordDonationResponse({
    required this.donationId,
    required this.pitNetDeductionPln,
    required this.awardedBadgeIds,
    this.notificationId,
  });
}
