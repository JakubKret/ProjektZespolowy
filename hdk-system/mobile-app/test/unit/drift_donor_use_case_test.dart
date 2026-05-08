import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdk_mobile_app/core/contracts/async_state.dart';
import 'package:hdk_mobile_app/core/contracts/dtos/donation_dtos.dart';
import 'package:hdk_mobile_app/core/contracts/dtos/donor_profile_dtos.dart';
import 'package:hdk_mobile_app/core/contracts/dtos/notification_dtos.dart';
import 'package:hdk_mobile_app/core/database/app_database.dart';
import 'package:hdk_mobile_app/core/use_cases/drift_donor_use_case.dart';
import 'package:hdk_mobile_app/core/workflows/donor_workflow_service.dart';

void main() {
  late AppDatabase db;
  late DriftDonorUseCase useCase;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    useCase = DriftDonorUseCase(DonorWorkflowService(db));
  });

  tearDown(() async {
    await db.close();
  });

  test('createDonorProfile emits loading then success', () async {
    final states = await useCase
        .createDonorProfile(
          CreateDonorProfileRequest(
            firstName: 'Jan',
            lastName: 'Kowalski',
            birthDate: DateTime(1990, 1, 1),
            sex: 'M',
          ),
        )
        .toList();

    expect(states.first.status, AsyncStatus.loading);
    expect(states.last.status, AsyncStatus.success);
    expect(states.last.data!.donorProfileId, isPositive);
  });

  test('recordDonation emits loading then success', () async {
    final donorId = await db.donorProfileDao.createProfile(
      DonorProfileTableCompanion.insert(
        firstName: 'Jan',
        lastName: 'Kowalski',
        birthDate: DateTime(1990, 1, 1),
        sex: 'M',
      ),
    );
    final centerId = await db.bloodCentersDao.createCenter(
      BloodCentersTableCompanion.insert(name: 'RCKiK', city: 'Warszawa'),
    );

    final states = await useCase
        .recordDonation(
          RecordDonationRequest(
            donorProfileId: donorId,
            bloodCenterId: centerId,
            donationDate: DateTime(2026, 1, 1),
            volumeMl: 450,
            annualIncomePln: 100000,
          ),
        )
        .toList();

    expect(states.first.status, AsyncStatus.loading);
    expect(states.last.status, AsyncStatus.success);
    expect(states.last.data!.donationId, isPositive);
  });

  test('sendDueNotifications emits loading then success', () async {
    final donorId = await db.donorProfileDao.createProfile(
      DonorProfileTableCompanion.insert(
        firstName: 'Anna',
        lastName: 'Nowak',
        birthDate: DateTime(1992, 1, 1),
        sex: 'F',
      ),
    );

    await db.notificationLogDao.createNotification(
      NotificationLogTableCompanion.insert(
        donorProfileId: donorId,
        notificationType: 'eligibility',
        scheduledAt: DateTime(2026, 1, 1, 10),
      ),
    );

    final states = await useCase
        .sendDueNotifications(
          SendDueNotificationsRequest(
            asOf: DateTime(2026, 1, 1, 12),
          ),
        )
        .toList();

    expect(states.first.status, AsyncStatus.loading);
    expect(states.last.status, AsyncStatus.success);
    expect(states.last.data!.sentCount, 1);
  });
}
