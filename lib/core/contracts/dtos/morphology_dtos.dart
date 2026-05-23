class SaveMorphologyRequest {
  final int donorProfileId;
  final DateTime resultDate;
  final int? donationId;
  final double? hgbGDl;
  final double? ferritinNgMl;
  final bool isVerified;

  const SaveMorphologyRequest({
    required this.donorProfileId,
    required this.resultDate,
    this.donationId,
    this.hgbGDl,
    this.ferritinNgMl,
    this.isVerified = false,
  });
}

class MorphologyRiskResponse {
  final int morphologyResultId;
  final bool isRiskDetected;
  final int? notificationId;

  const MorphologyRiskResponse({
    required this.morphologyResultId,
    required this.isRiskDetected,
    this.notificationId,
  });
}
