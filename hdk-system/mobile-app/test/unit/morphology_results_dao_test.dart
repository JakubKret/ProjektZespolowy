import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdk_mobile_app/core/database/app_database.dart';
import 'package:hdk_mobile_app/core/database/daos/morphology_results_dao.dart';

void main() {
  late AppDatabase db;
  late MorphologyResultsDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = db.morphologyResultsDao;
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> insertDonor() {
    return db.into(db.donorProfileTable).insert(
          DonorProfileTableCompanion.insert(
            firstName: 'Anna',
            lastName: 'Nowak',
            birthDate: DateTime(1994, 2, 1),
            sex: 'F',
          ),
        );
  }

  MorphologyResultsTableCompanion morphologyFor(
    int donorId, {
    required DateTime resultDate,
    double? hgbGDl,
  }) {
    return MorphologyResultsTableCompanion.insert(
      donorId: donorId,
      resultDate: resultDate,
      hgbGDl: Value(hgbGDl),
    );
  }

  group('createResult', () {
    test('inserts morphology result and returns inserted id', () async {
      final donorId = await insertDonor();

      final resultId = await dao.createResult(
        morphologyFor(
          donorId,
          resultDate: DateTime(2026, 1, 10),
          hgbGDl: 14.2,
        ),
      );

      final row = await (db.select(db.morphologyResultsTable)
            ..where((t) => t.id.equals(resultId)))
          .getSingle();

      expect(row.id, resultId);
      expect(row.donorId, donorId);
      expect(row.hgbGDl, 14.2);
    });
  });

  group('getResultsForDonor and watchResultsForDonor', () {
    test('returns only selected donor results ordered by date descending',
        () async {
      final donor1 = await insertDonor();
      final donor2 = await insertDonor();

      await dao.createResult(
        morphologyFor(donor1, resultDate: DateTime(2026, 1, 1)),
      );
      await dao.createResult(
        morphologyFor(donor1, resultDate: DateTime(2026, 3, 1)),
      );
      await dao.createResult(
        morphologyFor(donor2, resultDate: DateTime(2026, 4, 1)),
      );

      final rows = await dao.getResultsForDonor(donor1);

      expect(rows, hasLength(2));
      expect(rows.map((e) => e.resultDate).toList(), [
        DateTime(2026, 3, 1),
        DateTime(2026, 1, 1),
      ]);
      expect(rows.every((e) => e.donorId == donor1), isTrue);
    });

    test('watch stream emits donor-specific list in expected order', () async {
      final donorId = await insertDonor();

      await dao.createResult(
        morphologyFor(donorId, resultDate: DateTime(2026, 2, 1)),
      );
      await dao.createResult(
        morphologyFor(donorId, resultDate: DateTime(2026, 5, 1)),
      );

      final rows = await dao.watchResultsForDonor(donorId).first;

      expect(rows.map((e) => e.resultDate).toList(), [
        DateTime(2026, 5, 1),
        DateTime(2026, 2, 1),
      ]);
    });
  });

  group('deleteResult', () {
    test('removes one result and keeps others', () async {
      final donorId = await insertDonor();

      final idToDelete = await dao.createResult(
        morphologyFor(donorId, resultDate: DateTime(2026, 1, 1)),
      );
      await dao.createResult(
        morphologyFor(donorId, resultDate: DateTime(2026, 2, 1)),
      );

      await dao.deleteResult(idToDelete);

      final rows = await dao.getResultsForDonor(donorId);
      expect(rows, hasLength(1));
      expect(rows.single.id, isNot(idToDelete));
    });
  });
}
