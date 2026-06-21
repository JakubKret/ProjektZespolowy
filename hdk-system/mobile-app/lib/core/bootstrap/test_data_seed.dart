import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../database/app_database.dart';
import '../workflows/donor_workflow_service.dart';
import 'reference_data_seed.dart';

class TestDataSeed {
  static const testEmail = 'test@hdk.pl';
  static const testPassword = 'test123';
  static const testFirstName = 'Jan';
  static const testLastName = 'Kowalski';
  static const testSex = 'M';
  static const testBloodType = '0';
  static const testRhFactor = '+';

  static String get _passwordHash =>
      sha256.convert(utf8.encode(testPassword)).toString();

  static Future<int> ensureTestUser(
    AppDatabase db,
    DonorWorkflowService workflow,
  ) async {
    await ReferenceDataSeed.ensureSeeded(db, workflow);

    final existing = await db.donorProfileDao.getProfileByEmail(testEmail);
    if (existing != null) return existing.id;

    final donorId = await workflow.createDonorProfile(
      email: testEmail,
      passwordHash: _passwordHash,
      firstName: testFirstName,
      lastName: testLastName,
      birthDate: DateTime(1995, 3, 15),
      sex: testSex,
      bloodType: testBloodType,
      rhFactor: testRhFactor,
    );

    final centers = await db.bloodCentersDao.getAllCenters();
    final centerIds = centers.map((c) => c.id).toList();

    if (centerIds.isNotEmpty) {
      final donations = [
        (date: DateTime(2024, 1, 10), volume: 450, center: centerIds[0]),
        (date: DateTime(2024, 4, 20), volume: 450, center: centerIds[0]),
        (date: DateTime(2024, 8, 5), volume: 450, center: centerIds.length > 1 ? centerIds[1] : centerIds[0]),
        (date: DateTime(2024, 11, 15), volume: 450, center: centerIds[0]),
        (date: DateTime(2025, 3, 1), volume: 450, center: centerIds.length > 2 ? centerIds[2] : centerIds[0]),
        (date: DateTime(2025, 6, 20), volume: 450, center: centerIds[0]),
        (date: DateTime(2025, 10, 10), volume: 450, center: centerIds.length > 1 ? centerIds[1] : centerIds[0]),
        (date: DateTime(2026, 1, 15), volume: 450, center: centerIds[0]),
      ];

      for (final d in donations) {
        await workflow.recordDonationAndRefreshBenefits(
          donorProfileId: donorId,
          bloodCenterId: d.center,
          donationDate: d.date,
          volumeMl: d.volume,
          annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
        );
      }
    }

    await workflow.backfillDerivedDataForDonor(
      donorProfileId: donorId,
      annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
    );

    return donorId;
  }
}
