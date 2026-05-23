import 'package:drift/drift.dart';

import '../../database/app_database.dart';

class DonorProfileWorkflowService {
  final AppDatabase _db;

  DonorProfileWorkflowService(this._db);

  Future<int> createDonorProfile({
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String sex,
    String? bloodType,
    String? rhFactor,
  }) {
    return _db.donorProfileDao.createProfile(
      DonorProfileTableCompanion.insert(
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        sex: sex,
        bloodType: Value(bloodType),
        rhFactor: Value(rhFactor),
      ),
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
  }) async {
    final donor = await _db.donorProfileDao.getProfileById(donorProfileId);
    if (donor == null) {
      return false;
    }
    return _db.donorProfileDao.updateProfile(
      donor.copyWith(
        firstName: firstName ?? donor.firstName,
        lastName: lastName ?? donor.lastName,
        birthDate: birthDate ?? donor.birthDate,
        sex: sex ?? donor.sex,
        bloodType: Value(bloodType ?? donor.bloodType),
        rhFactor: Value(rhFactor ?? donor.rhFactor),
      ),
    );
  }

  Future<int> deleteDonorProfile(int donorProfileId) {
    return _db.donorProfileDao.deleteProfile(donorProfileId);
  }
}
