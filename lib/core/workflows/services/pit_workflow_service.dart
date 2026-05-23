import '../../database/app_database.dart';

class PitWorkflowService {
  final AppDatabase _db;

  PitWorkflowService(this._db);

  Future<PitAnnualSummaryTableData> recalculatePitForYear({
    required int donorProfileId,
    required int taxYear,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) {
    return _db.pitAnnualSummaryDao.recalculateYear(
      donorProfileId: donorProfileId,
      taxYear: taxYear,
      annualIncomePln: annualIncomePln,
      otherDonationsPln: otherDonationsPln,
    );
  }

  Future<List<PitAnnualSummaryTableData>> recalculateAllPitYearsForDonor({
    required int donorProfileId,
    required double annualIncomePln,
    double otherDonationsPln = 0.0,
  }) async {
    final donations = await _db.donationsDao.getDonationsForDonor(donorProfileId);
    final years = donations.map((d) => d.donationDate.year).toSet().toList()..sort();
    final summaries = <PitAnnualSummaryTableData>[];
    for (final year in years) {
      final summary = await recalculatePitForYear(
        donorProfileId: donorProfileId,
        taxYear: year,
        annualIncomePln: annualIncomePln,
        otherDonationsPln: otherDonationsPln,
      );
      summaries.add(summary);
    }
    return summaries;
  }
}
