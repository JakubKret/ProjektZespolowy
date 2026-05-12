import 'dart:math' as math;

import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/donations_table.dart';
import '../tables/pit_annual_summary_table.dart';

part 'pit_annual_summary_dao.g.dart';

@DriftAccessor(tables: [DonationsTable, PitAnnualSummaryTable])
class PitAnnualSummaryDao extends DatabaseAccessor<AppDatabase>
    with _$PitAnnualSummaryDaoMixin {
  PitAnnualSummaryDao(super.db);

  static const double _plnPerLiter = 130.0;
  static const double _incomeCapRate = 0.06;

  Future<PitAnnualSummaryTableData> recalculateYear({
    required int donorProfileId,
    required int taxYear,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) async {
    final yearStart = DateTime(taxYear, 1, 1);
    final nextYearStart = DateTime(taxYear + 1, 1, 1);
    final volumeSumExpr = donationsTable.volumeMl.sum();

    return transaction(() async {
      final row =
          await (selectOnly(donationsTable)
                ..addColumns([volumeSumExpr])
                ..where(
                  donationsTable.donorProfileId.equals(donorProfileId) &
                      donationsTable.isRejected.equals(false) &
                      donationsTable.donationDate.isBiggerOrEqualValue(yearStart) &
                      donationsTable.donationDate.isSmallerThanValue(nextYearStart),
                ))
              .getSingle();

      final totalVolumeMl = row.read(volumeSumExpr) ?? 0;
      final grossDeductionPln = _round2((totalVolumeMl / 1000.0) * _plnPerLiter);
      final income6PctCap = _round2(annualIncomePln * _incomeCapRate);
      final availableCap = _round2(math.max(0.0, income6PctCap - otherDonationsPln));
      final netDeductionPln = _round2(math.min(grossDeductionPln, availableCap));

      final summary = PitAnnualSummaryTableCompanion.insert(
        donorProfileId: donorProfileId,
        taxYear: taxYear,
        totalVolumeMl: totalVolumeMl,
        ratePlnPerLiter: _plnPerLiter,
        grossDeductionPln: grossDeductionPln,
        income6PctCap: income6PctCap,
        netDeductionPln: netDeductionPln,
        lastCalculatedAt: Value(DateTime.now()),
      );

      final existing =
          await (select(pitAnnualSummaryTable)
                ..where(
                  (t) =>
                      t.donorProfileId.equals(donorProfileId) &
                      t.taxYear.equals(taxYear),
                ))
              .getSingleOrNull();

      if (existing == null) {
        await into(pitAnnualSummaryTable).insert(summary);
      } else {
        await (update(pitAnnualSummaryTable)..where((t) => t.id.equals(existing.id)))
            .write(summary);
      }

      return (select(pitAnnualSummaryTable)
            ..where(
              (t) =>
                  t.donorProfileId.equals(donorProfileId) &
                  t.taxYear.equals(taxYear),
            ))
          .getSingle();
    });
  }

  Stream<PitAnnualSummaryTableData?> watchSummary(int donorProfileId, int taxYear) {
    return (select(pitAnnualSummaryTable)
          ..where(
            (t) =>
                t.donorProfileId.equals(donorProfileId) &
                t.taxYear.equals(taxYear),
          ))
        .watchSingleOrNull();
  }

  Future<List<PitAnnualSummaryTableData>> getAll(int donorProfileId) {
    return (select(pitAnnualSummaryTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId))
          ..orderBy([(t) => OrderingTerm.desc(t.taxYear)]))
        .get();
  }

  Future<void> deleteSummary(int donorProfileId) {
    return (delete(pitAnnualSummaryTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId)))
        .go();
  }

  double _round2(double value) => (value * 100).roundToDouble() / 100.0;
}