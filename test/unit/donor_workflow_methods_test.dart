import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:krwiodawstwo/core/database/app_database.dart';
import 'package:krwiodawstwo/core/workflows/donor_workflow_service.dart';

void main() {
  late AppDatabase db;
  late DonorWorkflowService service;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    service = DonorWorkflowService(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> seedDonor() {
    //seed :)) ;)) 8==D
    return service.createDonorProfile(
      firstName: 'Jan',
      lastName: 'Kowalski',
      birthDate: DateTime(1990, 1, 1),
      sex: 'M',
    );
  }

  Future<int> seedCenter() {
    return db.bloodCentersDao.createCenter(
      BloodCentersTableCompanion.insert(name: 'RCKiK', city: 'Warszawa'),
    );
  }

  test('create/update/delete donor profile workflow', () async {
    final donorId = await seedDonor();

    final updated = await service.updateDonorProfile(
      donorProfileId: donorId,
      lastName: 'Nowak',
    );
    expect(updated, isTrue);
    expect(
      (await db.donorProfileDao.getProfileById(donorId))!.lastName,
      'Nowak',
    );

    final deleted = await service.deleteDonorProfile(donorId);
    expect(deleted, 1);
    expect(await db.donorProfileDao.getProfileById(donorId), isNull);
  });

  test('mark and clear donation rejection workflow', () async {
    final donorId = await seedDonor();
    final centerId = await seedCenter();
    final donationId = await db.donationsDao.createDonation(
      DonationsTableCompanion.insert(
        donorProfileId: donorId,
        bloodCenterId: centerId,
        donationType: 'whole_blood',
        donationDate: DateTime(2026, 1, 1),
        volumeMl: 450,
      ),
    );

    await service.markDonationRejected(
      donationId: donationId,
      rejectionReason: 'low_hgb',
      annualIncomePln: 100000,
    );
    expect(
      (await db.donationsDao.getDonationById(donationId))!.isRejected,
      isTrue,
    );

    await service.clearDonationRejection(
      donationId: donationId,
      annualIncomePln: 100000,
    );
    expect(
      (await db.donationsDao.getDonationById(donationId))!.isRejected,
      isFalse,
    );
  });

  test('morphology risk workflow creates risk notification', () async {
    final donorId = await seedDonor();

    final result = await service.saveMorphologyResultAndEvaluateRisk(
      donorProfileId: donorId,
      resultDate: DateTime(2026, 5, 1),
      hgbGDl: 11.5,
    );

    expect(result.isRiskDetected, isTrue);
    expect(result.notificationId, isNotNull);
  });

  test(
    'notification sending workflow marks due notifications as sent',
    () async {
      final donorId = await seedDonor();
      await service.scheduleEligibilityNotifications(
        donorProfileId: donorId,
        nextEligibleAt: DateTime(2026, 5, 1, 10),
        reason: 'recent_donation_wait',
      );

      final sendResult = await service.sendDueNotifications(
        asOf: DateTime(2026, 5, 1, 12),
      );

      expect(sendResult.sentCount, 1);
      final notifications =
          await db.notificationLogDao.getNotificationsForDonor(donorId);
      expect(notifications.single.sentAt, isNotNull);
    },
  );
}
