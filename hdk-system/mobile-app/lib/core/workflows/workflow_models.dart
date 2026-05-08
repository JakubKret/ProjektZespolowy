class DonationWorkflowResult {
  final int donationId;
  final double pitNetDeductionPln;
  final List<int> awardedBadgeIds;
  final int? notificationId;

  const DonationWorkflowResult({
    required this.donationId,
    required this.pitNetDeductionPln,
    required this.awardedBadgeIds,
    this.notificationId,
  });
}

class EligibilityStatus {
  final bool canDonate;
  final DateTime nextEligibleAt;
  final String reason;

  const EligibilityStatus({
    required this.canDonate,
    required this.nextEligibleAt,
    required this.reason,
  });
}

class MorphologyRiskResult {
  final int morphologyResultId;
  final bool isRiskDetected;
  final int? notificationId;

  const MorphologyRiskResult({
    required this.morphologyResultId,
    required this.isRiskDetected,
    this.notificationId,
  });
}

class SentNotificationsResult {
  final int sentCount;
  final List<int> sentNotificationIds;

  const SentNotificationsResult({
    required this.sentCount,
    required this.sentNotificationIds,
  });
}

class BloodCenterSyncInput {
  final String name;
  final String city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool isMobile;
  final String? phone;
  final String? operatingHoursJson;

  const BloodCenterSyncInput({
    required this.name,
    required this.city,
    this.address,
    this.latitude,
    this.longitude,
    this.isMobile = false,
    this.phone,
    this.operatingHoursJson,
  });
}

class BadgeDefinitionSyncInput {
  final String badgeCode;
  final String name;
  final double? thresholdLitersMale;
  final double? thresholdLitersFemale;
  final String issuingBody;
  final String? privilegesJson;

  const BadgeDefinitionSyncInput({
    required this.badgeCode,
    required this.name,
    required this.issuingBody,
    this.thresholdLitersMale,
    this.thresholdLitersFemale,
    this.privilegesJson,
  });
}
