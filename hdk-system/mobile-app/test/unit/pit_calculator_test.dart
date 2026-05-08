import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdk_mobile_app/core/database/app_database.dart';
import 'package:hdk_mobile_app/core/database/daos/pit_annual_summary_dao.dart';

void main() {
  late AppDatabase db;
  late PitAnnualSummaryDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = db.pitAnnualSummaryDao;
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> insertDonor() {
    return db.into(db.donorProfileTable).insert(
          DonorProfileTableCompanion.insert(
            firstName: 'Jan',
            lastName: 'Kowalski',
            birthDate: DateTime(1990, 1, 1),
            sex: 'M',
          ),
        );
  }

  Future<int> insertBloodCenter() {
    return db.into(db.bloodCentersTable).insert(
          BloodCentersTableCompanion.insert(
            name: 'RCKiK',
            city: 'Warszawa',
          ),
        );
  }

  Future<void> insertDonation({
    required int donorId,
    required int bloodCenterId,
    required DateTime date,
    required int volumeMl,
    bool isRejected = false,
  }) {
    return db.into(db.donationsTable).insert(
          DonationsTableCompanion.insert(
            donorProfileId: donorId,
            bloodCenterId: bloodCenterId,
            donationType: 'whole_blood',
            donationDate: date,
            volumeMl: volumeMl,
            isRejected: Value(isRejected),
          ),
        );
  }

  group('recalculateYear', () {
    test('calculates annual PIT summary using accepted donations only', () async {
      final donorId = await insertDonor();
      final bloodCenterId = await insertBloodCenter();

      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 1, 10),
        volumeMl: 450,
      );
      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 3, 12),
        volumeMl: 500,
      );
      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 7, 1),
        volumeMl: 400,
        isRejected: true,
      );
      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2025, 12, 31),
        volumeMl: 450,
      );

      final summary = await dao.recalculateYear(
        donorProfileId: donorId,
        taxYear: 2026,
        annualIncomePln: 100000,
      );

      expect(summary.totalVolumeMl, 950);
      expect(summary.grossDeductionPln, 123.5);
      expect(summary.income6PctCap, 6000.0);
      expect(summary.netDeductionPln, 123.5);
    });

    test('applies income cap minus other donation deductions', () async {
      final donorId = await insertDonor();
      final bloodCenterId = await insertBloodCenter();

      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 4, 20),
        volumeMl: 1000,
      );

      final summary = await dao.recalculateYear(
        donorProfileId: donorId,
        taxYear: 2026,
        annualIncomePln: 1000,
        otherDonationsPln: 30.0,
      );

      expect(summary.grossDeductionPln, 130.0);
      expect(summary.income6PctCap, 60.0);
      expect(summary.netDeductionPln, 30.0);
    });

    test('updates existing year summary instead of inserting duplicate', () async {
      final donorId = await insertDonor();
      final bloodCenterId = await insertBloodCenter();

      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 2, 1),
        volumeMl: 450,
      );

      final first = await dao.recalculateYear(
        donorProfileId: donorId,
        taxYear: 2026,
        annualIncomePln: 100000,
      );

      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 8, 1),
        volumeMl: 500,
      );

      final second = await dao.recalculateYear(
        donorProfileId: donorId,
        taxYear: 2026,
        annualIncomePln: 100000,
      );

      final allRows = await dao.getAll(donorId);
      expect(allRows, hasLength(1));
      expect(second.id, first.id);
      expect(second.totalVolumeMl, 950);
    });
  });

  group('getAll and deleteSummary', () {
    test('returns summaries ordered by year descending', () async {
      final donorId = await insertDonor();
      final bloodCenterId = await insertBloodCenter();

      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2025, 6, 1),
        volumeMl: 450,
      );
      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 6, 1),
        volumeMl: 450,
      );

      await dao.recalculateYear(
        donorProfileId: donorId,
        taxYear: 2025,
        annualIncomePln: 100000,
      );
      await dao.recalculateYear(
        donorProfileId: donorId,
        taxYear: 2026,
        annualIncomePln: 100000,
      );

      final rows = await dao.getAll(donorId);
      expect(rows.map((e) => e.taxYear).toList(), [2026, 2025]);
    });

    test('deletes all summaries for selected donor only', () async {
      final donor1 = await insertDonor();
      final donor2 = await insertDonor();
      final bloodCenterId = await insertBloodCenter();

      await insertDonation(
        donorId: donor1,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 6, 1),
        volumeMl: 450,
      );
      await insertDonation(
        donorId: donor2,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 6, 1),
        volumeMl: 450,
      );

      await dao.recalculateYear(
        donorProfileId: donor1,
        taxYear: 2026,
        annualIncomePln: 100000,
      );
      await dao.recalculateYear(
        donorProfileId: donor2,
        taxYear: 2026,
        annualIncomePln: 100000,
      );

      await dao.deleteSummary(donor1);

      expect(await dao.getAll(donor1), isEmpty);
      expect(await dao.getAll(donor2), hasLength(1));
    });
  });

  group('watchSummary', () {
    test('emits the summary for requested donor and year', () async {
      final donorId = await insertDonor();
      final bloodCenterId = await insertBloodCenter();

      await insertDonation(
        donorId: donorId,
        bloodCenterId: bloodCenterId,
        date: DateTime(2026, 6, 1),
        volumeMl: 450,
      );

      await dao.recalculateYear(
        donorProfileId: donorId,
        taxYear: 2026,
        annualIncomePln: 100000,
      );

      final watched = await dao.watchSummary(donorId, 2026).first;
      expect(watched, isNotNull);
      expect(watched!.donorProfileId, donorId);
      expect(watched.taxYear, 2026);
    });
  });
}
