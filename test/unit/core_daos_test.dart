import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:krwiodawstwo/core/database/app_database.dart';
import 'package:krwiodawstwo/core/database/daos/blood_centers_dao.dart';
import 'package:krwiodawstwo/core/database/daos/donor_badges_earned_dao.dart';
import 'package:krwiodawstwo/core/database/daos/donor_profile_dao.dart';
import 'package:krwiodawstwo/core/database/daos/donations_dao.dart';
import 'package:krwiodawstwo/core/database/daos/notification_log_dao.dart';
import 'package:krwiodawstwo/core/database/daos/zhdk_badge_definitions_dao.dart';

void main() {
  late AppDatabase db;
  late DonorProfileDao donorProfileDao;
  late DonationsDao donationsDao;
  late BloodCentersDao bloodCentersDao;
  late ZhdkBadgeDefinitionsDao badgeDefinitionsDao;
  late DonorBadgesEarnedDao donorBadgesEarnedDao;
  late NotificationLogDao notificationLogDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    donorProfileDao = db.donorProfileDao;
    donationsDao = db.donationsDao;
    bloodCentersDao = db.bloodCentersDao;
    badgeDefinitionsDao = db.zhdkBadgeDefinitionsDao;
    donorBadgesEarnedDao = db.donorBadgesEarnedDao;
    notificationLogDao = db.notificationLogDao;
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> insertDonor({
    String firstName = 'Jan',
    String lastName = 'Kowalski',
    DateTime? birthDate,
    String sex = 'M',
  }) {
    return donorProfileDao.createProfile(
      DonorProfileTableCompanion.insert(
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate ?? DateTime(1990, 1, 1),
        sex: sex,
      ),
    );
  }

  Future<int> insertCenter({
    String name = 'RCKiK',
    String city = 'Warszawa',
  }) {
    return bloodCentersDao.createCenter(
      BloodCentersTableCompanion.insert(name: name, city: city),
    );
  }

  group('DonorProfileDao', () {
    test('creates, reads, updates and deletes profile', () async {
      final id = await insertDonor(firstName: 'Adam');
      final created = await donorProfileDao.getProfileById(id);
      expect(created, isNotNull);
      expect(created!.firstName, 'Adam');

      final updated = created.copyWith(lastName: 'Nowak');
      final didUpdate = await donorProfileDao.updateProfile(updated);
      expect(didUpdate, isTrue);
      expect((await donorProfileDao.getProfileById(id))!.lastName, 'Nowak');

      final deletedRows = await donorProfileDao.deleteProfile(id);
      expect(deletedRows, 1);
      expect(await donorProfileDao.getProfileById(id), isNull);
    });
  });

  group('BloodCentersDao', () {
    test('returns all centers sorted by city then name', () async {
      await insertCenter(name: 'Center B', city: 'Krakow');
      await insertCenter(name: 'Center A', city: 'Krakow');
      await insertCenter(name: 'Center C', city: 'Warszawa');

      final rows = await bloodCentersDao.getAllCenters();
      expect(rows.map((e) => '${e.city}-${e.name}').toList(), [
        'Krakow-Center A',
        'Krakow-Center B',
        'Warszawa-Center C',
      ]);
    });
  });

  group('DonationsDao', () {
    test('creates and fetches donor donations in descending date order',
        () async {
      final donorId = await insertDonor();
      final otherDonorId = await insertDonor(firstName: 'Piotr');
      final centerId = await insertCenter();

      await donationsDao.createDonation(
        DonationsTableCompanion.insert(
          donorProfileId: donorId,
          bloodCenterId: centerId,
          donationType: 'whole_blood',
          donationDate: DateTime(2026, 1, 1),
          volumeMl: 450,
        ),
      );
      await donationsDao.createDonation(
        DonationsTableCompanion.insert(
          donorProfileId: donorId,
          bloodCenterId: centerId,
          donationType: 'whole_blood',
          donationDate: DateTime(2026, 3, 1),
          volumeMl: 500,
        ),
      );
      await donationsDao.createDonation(
        DonationsTableCompanion.insert(
          donorProfileId: otherDonorId,
          bloodCenterId: centerId,
          donationType: 'whole_blood',
          donationDate: DateTime(2026, 2, 1),
          volumeMl: 450,
        ),
      );

      final rows = await donationsDao.getDonationsForDonor(donorId);
      expect(rows, hasLength(2));
      expect(rows.map((e) => e.donationDate).toList(), [
        DateTime(2026, 3, 1),
        DateTime(2026, 1, 1),
      ]);
    });
  });

  group('ZhdkBadgeDefinitionsDao', () {
    test('creates and reads badge by badgeCode', () async {
      await badgeDefinitionsDao.createBadgeDefinition(
        ZhdkBadgeDefinitionsTableCompanion.insert(
          badgeCode: 'BRONZE',
          name: 'Bronze Badge',
          issuingBody: 'PCK',
        ),
      );

      final badge = await badgeDefinitionsDao.getByBadgeCode('BRONZE');
      expect(badge, isNotNull);
      expect(badge!.name, 'Bronze Badge');
    });
  });

  group('DonorBadgesEarnedDao', () {
    test('awards badge and lists donor badges ordered by earnedDate', () async {
      final donorId = await insertDonor();
      final badgeId = await badgeDefinitionsDao.createBadgeDefinition(
        ZhdkBadgeDefinitionsTableCompanion.insert(
          badgeCode: 'SILVER',
          name: 'Silver Badge',
          issuingBody: 'PCK',
        ),
      );

      await donorBadgesEarnedDao.awardBadge(
        DonorBadgesEarnedTableCompanion.insert(
          donorProfileId: donorId,
          badgeId: badgeId,
          earnedDate: DateTime(2025, 1, 1),
          totalLitersAtEarn: 6.0,
        ),
      );
      await donorBadgesEarnedDao.awardBadge(
        DonorBadgesEarnedTableCompanion.insert(
          donorProfileId: donorId,
          badgeId: badgeId,
          earnedDate: DateTime(2026, 1, 1),
          totalLitersAtEarn: 12.0,
        ),
      );

      final rows = await donorBadgesEarnedDao.getEarnedBadgesForDonor(donorId);
      expect(rows, hasLength(2));
      expect(rows.first.earnedDate, DateTime(2026, 1, 1));
    });
  });

  group('NotificationLogDao', () {
    test('returns only pending due notifications', () async {
      final donorId = await insertDonor();
      final now = DateTime(2026, 5, 1, 12);

      await notificationLogDao.createNotification(
        NotificationLogTableCompanion.insert(
          donorProfileId: donorId,
          notificationType: 'eligibility',
          scheduledAt: DateTime(2026, 5, 1, 11),
        ),
      );
      await notificationLogDao.createNotification(
        NotificationLogTableCompanion.insert(
          donorProfileId: donorId,
          notificationType: 'future',
          scheduledAt: DateTime(2026, 5, 1, 13),
        ),
      );

      final sentId = await notificationLogDao.createNotification(
        NotificationLogTableCompanion.insert(
          donorProfileId: donorId,
          notificationType: 'already_sent',
          scheduledAt: DateTime(2026, 5, 1, 10),
        ),
      );
      await notificationLogDao.markSent(sentId,
          sentAt: DateTime(2026, 5, 1, 10, 5));

      final dismissedId = await notificationLogDao.createNotification(
        NotificationLogTableCompanion.insert(
          donorProfileId: donorId,
          notificationType: 'dismissed',
          scheduledAt: DateTime(2026, 5, 1, 9),
        ),
      );
      await notificationLogDao.dismiss(dismissedId);

      final pending =
          await notificationLogDao.getPendingNotifications(asOf: now);
      expect(pending, hasLength(1));
      expect(pending.single.notificationType, 'eligibility');
    });

    test('markSent sets sentAt and dismiss sets isDismissed', () async {
      final donorId = await insertDonor();
      final id = await notificationLogDao.createNotification(
        NotificationLogTableCompanion.insert(
          donorProfileId: donorId,
          notificationType: 'eligibility',
          scheduledAt: DateTime(2026, 5, 2),
        ),
      );

      final sentAt = DateTime(2026, 5, 2, 9);
      await notificationLogDao.markSent(id, sentAt: sentAt);
      await notificationLogDao.dismiss(id);

      final row =
          (await notificationLogDao.getNotificationsForDonor(donorId)).single;
      expect(row.sentAt, sentAt);
      expect(row.isDismissed, isTrue);
    });
  });
}
