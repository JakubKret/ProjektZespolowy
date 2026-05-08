import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../workflow_models.dart';

class BadgeWorkflowService {
  final AppDatabase _db;

  BadgeWorkflowService(this._db);

  Future<List<int>> evaluateAndAwardBadges({
    required int donorProfileId,
    required DateTime earnedDate,
  }) async {
    final donor = await _db.donorProfileDao.getProfileById(donorProfileId);
    if (donor == null) {
      throw StateError('Donor not found: $donorProfileId');
    }

    final acceptedVolumeMl = await _db.donationsDao
        .getAcceptedVolumeMlForDonor(donorProfileId);
    final totalLiters = acceptedVolumeMl / 1000.0;

    final existingBadges = await _db.donorBadgesEarnedDao
        .getEarnedBadgesForDonor(donorProfileId);
    final existingBadgeIds = existingBadges.map((e) => e.badgeId).toSet();

    final badgeDefinitions = await _db.zhdkBadgeDefinitionsDao.getAllBadgeDefinitions();
    final awardedBadgeIds = <int>[];
    for (final badge in badgeDefinitions) {
      final threshold = donor.sex.toUpperCase() == 'F'
          ? badge.thresholdLitersFemale
          : badge.thresholdLitersMale;
      if (threshold == null) {
        continue;
      }
      final shouldAward =
          totalLiters >= threshold && !existingBadgeIds.contains(badge.id);
      if (!shouldAward) {
        continue;
      }
      await _db.donorBadgesEarnedDao.awardBadge(
        DonorBadgesEarnedTableCompanion.insert(
          donorProfileId: donorProfileId,
          badgeId: badge.id,
          earnedDate: earnedDate,
          totalLitersAtEarn: totalLiters,
        ),
      );
      awardedBadgeIds.add(badge.id);
    }
    return awardedBadgeIds;
  }

  Future<void> syncBadgeDefinitions(List<BadgeDefinitionSyncInput> badges) async {
    await _db.transaction(() async {
      for (final badge in badges) {
        final existing = await _db.zhdkBadgeDefinitionsDao.getByBadgeCode(badge.badgeCode);
        if (existing == null) {
          await _db.zhdkBadgeDefinitionsDao.createBadgeDefinition(
            ZhdkBadgeDefinitionsTableCompanion.insert(
              badgeCode: badge.badgeCode,
              name: badge.name,
              thresholdLitersMale: Value(badge.thresholdLitersMale),
              thresholdLitersFemale: Value(badge.thresholdLitersFemale),
              issuingBody: badge.issuingBody,
              privilegesJson: Value(badge.privilegesJson),
            ),
          );
        } else {
          await _db.zhdkBadgeDefinitionsDao.updateBadgeDefinition(
            existing.copyWith(
              name: badge.name,
              thresholdLitersMale: Value(badge.thresholdLitersMale),
              thresholdLitersFemale: Value(badge.thresholdLitersFemale),
              issuingBody: badge.issuingBody,
              privilegesJson: Value(badge.privilegesJson),
            ),
          );
        }
      }
    });
  }
}
