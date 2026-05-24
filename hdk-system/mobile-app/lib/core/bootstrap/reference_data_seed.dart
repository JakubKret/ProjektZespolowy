import '../database/app_database.dart';
import '../workflows/donor_workflow_service.dart';
import '../workflows/workflow_models.dart';

/// Ensures reference tables contain data required by workflows (FKs, badges).
class ReferenceDataSeed {
  static const _defaultAnnualIncomePln = 120000.0;

  static Future<void> ensureSeeded(
    AppDatabase db,
    DonorWorkflowService workflow,
  ) async {
    await _seedBadgeDefinitions(workflow);
    final centers = await db.bloodCentersDao.getAllCenters();
    if (centers.isEmpty) {
      await _seedDefaultBloodCenter(workflow);
    }
  }

  static Future<void> _seedBadgeDefinitions(DonorWorkflowService workflow) async {
    await workflow.syncBadgeDefinitions(const [
      BadgeDefinitionSyncInput(
        badgeCode: 'ZHDK_III',
        name: 'Zasłużony Honorowy Dawca Krwi III stopnia',
        thresholdLitersMale: 6,
        thresholdLitersFemale: 5,
        issuingBody: 'PCK',
        privilegesJson: '{"tier":"bronze"}',
      ),
      BadgeDefinitionSyncInput(
        badgeCode: 'ZHDK_II',
        name: 'Zasłużony Honorowy Dawca Krwi II stopnia',
        thresholdLitersMale: 12,
        thresholdLitersFemale: 10,
        issuingBody: 'PCK',
        privilegesJson: '{"tier":"silver"}',
      ),
      BadgeDefinitionSyncInput(
        badgeCode: 'ZHDK_I',
        name: 'Zasłużony Honorowy Dawca Krwi I stopnia',
        thresholdLitersMale: 18,
        thresholdLitersFemale: 15,
        issuingBody: 'PCK',
        privilegesJson: '{"tier":"gold"}',
      ),
      BadgeDefinitionSyncInput(
        badgeCode: 'HDK_MZ',
        name: 'HDK - Zasłużony dla Zdrowia Narodu',
        thresholdLitersMale: 20,
        thresholdLitersFemale: 18,
        issuingBody: 'MZ',
        privilegesJson: '{"tier":"national"}',
      ),
    ]);
  }

  static Future<void> _seedDefaultBloodCenter(
    DonorWorkflowService workflow,
  ) async {
    await workflow.syncBloodCenters(const [
      BloodCenterSyncInput(
        name: 'RCKiK we Wrocławiu',
        city: 'Wrocław',
        address: 'Czerwonego Krzyża 5/9',
        latitude: 51.1079,
        longitude: 17.0385,
        phone: '+48 71 123 45 67',
      ),
    ]);
  }

  static double get defaultAnnualIncomePln => _defaultAnnualIncomePln;
}
