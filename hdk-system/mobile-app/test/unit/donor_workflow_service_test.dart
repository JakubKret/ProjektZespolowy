import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdk_mobile_app/core/database/app_database.dart';
import 'package:hdk_mobile_app/core/workflows/donor_workflow_service.dart';

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

  Future<int> insertDonor({String sex = 'M'}) {
    return db.donorProfileDao.createProfile(
      DonorProfileTableCompanion.insert(
        firstName: 'Jan',
        lastName: 'Kowalski',
        birthDate: DateTime(1990, 1, 1),
        sex: sex,
      ),
    );
  }

  Future<int> insertCenter() {
    return db.bloodCentersDao.createCenter(
      BloodCentersTableCompanion.insert(name: 'RCKiK', city: 'Warszawa'),
    );
  }

  Future<int> insertBadge({
    required String code,
    required double maleThreshold,
  }) {
    return db.zhdkBadgeDefinitionsDao.createBadgeDefinition(
      ZhdkBadgeDefinitionsTableCompanion.insert(
        badgeCode: code,
        name: code,
        thresholdLitersMale: Value(maleThreshold),
        issuingBody: 'PCK',
      ),
    );
  }

  test('records donation, recalculates PIT and awards newly reached badges',
      () async {
    final donorId = await insertDonor(sex: 'M');
    final centerId = await insertCenter();
    final bronzeBadgeId = await insertBadge(code: 'BRONZE', maleThreshold: 0.4);
    await insertBadge(code: 'SILVER', maleThreshold: 1.0);

    final result = await service.recordDonationAndRefreshBenefits(
      donorProfileId: donorId,
      bloodCenterId: centerId,
      donationDate: DateTime(2026, 5, 1),
      volumeMl: 450,
      annualIncomePln: 100000,
    );

    expect(result.donationId, isPositive);
    expect(result.pitNetDeductionPln, 58.5);
    expect(result.awardedBadgeIds, [bronzeBadgeId]);
    expect(result.notificationId, isNotNull);

    final notifications = await db.notificationLogDao.getNotificationsForDonor(donorId);
    expect(notifications, hasLength(1));
    final payload = jsonDecode(notifications.single.payloadJson!);
    expect(payload['badgeIds'], [bronzeBadgeId]);
    expect(payload['donationId'], result.donationId);

    final pit = await db.pitAnnualSummaryDao.watchSummary(donorId, 2026).first;
    expect(pit, isNotNull);
    expect(pit!.totalVolumeMl, 450);
  });

  test('does not re-award already earned badges in later scenario runs',
      () async {
    final donorId = await insertDonor(sex: 'M');
    final centerId = await insertCenter();
    final bronzeBadgeId = await insertBadge(code: 'BRONZE', maleThreshold: 0.4);
    final silverBadgeId = await insertBadge(code: 'SILVER', maleThreshold: 1.0);

    final firstRun = await service.recordDonationAndRefreshBenefits(
      donorProfileId: donorId,
      bloodCenterId: centerId,
      donationDate: DateTime(2026, 1, 10),
      volumeMl: 450,
      annualIncomePln: 100000,
    );
    expect(firstRun.awardedBadgeIds, [bronzeBadgeId]);

    final secondRun = await service.recordDonationAndRefreshBenefits(
      donorProfileId: donorId,
      bloodCenterId: centerId,
      donationDate: DateTime(2026, 7, 10),
      volumeMl: 600,
      annualIncomePln: 100000,
    );
    expect(secondRun.awardedBadgeIds, [silverBadgeId]);

    final earned = await db.donorBadgesEarnedDao.getEarnedBadgesForDonor(donorId);
    expect(earned.map((e) => e.badgeId).toSet(), {bronzeBadgeId, silverBadgeId});
    expect(earned, hasLength(2));
  });
}
