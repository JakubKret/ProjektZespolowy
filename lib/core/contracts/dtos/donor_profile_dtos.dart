class CreateDonorProfileRequest {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final String sex;
  final String? bloodType;
  final String? rhFactor;

  const CreateDonorProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.sex,
    this.bloodType,
    this.rhFactor,
  });
}

class DonorProfileResponse {
  final int donorProfileId;

  const DonorProfileResponse({required this.donorProfileId});
}
