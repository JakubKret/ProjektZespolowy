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
    await _seedBloodCenters(workflow);
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

  static Future<void> _seedBloodCenters(
    DonorWorkflowService workflow,
  ) async {
    await workflow.syncBloodCenters(const [
      BloodCenterSyncInput(
        name: 'RCKiK w Białymstoku',
        city: 'Białystok',
        address: 'ul. Marii Skłodowskiej-Curie 23',
        latitude: 53.1325,
        longitude: 23.1688,
        phone: 'tel. (85) 744 70 02',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Bydgoszczy',
        city: 'Bydgoszcz',
        address: 'ul. Ks. Markwarta 8',
        latitude: 53.1235,
        longitude: 18.0084,
        phone: 'tel. (52) 322 18 71 do 74',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Gdańsku',
        city: 'Gdańsk',
        address: 'ul. J. Hoene-Wrońskiego 4',
        latitude: 54.3520,
        longitude: 18.6466,
        phone: 'tel. (58) 520 40 20',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Kaliszu',
        city: 'Kalisz',
        address: 'ul. Kaszubska 9',
        latitude: 51.7577,
        longitude: 18.0853,
        phone: 'tel. (62) 767 66 63',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Katowicach',
        city: 'Katowice',
        address: 'ul. Raciborska 15',
        latitude: 50.2549,
        longitude: 19.0238,
        phone: 'tel. (32) 208 73 00',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Kielcach',
        city: 'Kielce',
        address: 'ul. Jagiellońska 66',
        latitude: 50.8661,
        longitude: 20.6286,
        phone: 'tel. (41) 335 94 00',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Krakowie',
        city: 'Kraków',
        address: 'ul. Rzeźnicza 11',
        latitude: 50.0510,
        longitude: 19.9445,
        phone: 'tel. (12) 261 88 20',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Lublinie',
        city: 'Lublin',
        address: 'ul. Żołnierzy Niepodległej 8',
        latitude: 51.2465,
        longitude: 22.5684,
        phone: 'tel. (81) 532 62 75',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Łodzi',
        city: 'Łódź',
        address: 'ul. Franciszkańska 17/25',
        latitude: 51.7769,
        longitude: 19.4540,
        phone: 'tel. (42) 616 14 00',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Olsztynie',
        city: 'Olsztyn',
        address: 'ul. Malborska 2',
        latitude: 53.7784,
        longitude: 20.4801,
        phone: 'tel. (89) 526 01 56',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Opolu',
        city: 'Opole',
        address: 'ul. Kośnego 55',
        latitude: 50.6752,
        longitude: 17.9213,
        phone: 'tel. (77) 441 06 00',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Poznaniu',
        city: 'Poznań',
        address: 'ul. Marcelińska 44',
        latitude: 52.3989,
        longitude: 16.8780,
        phone: 'tel. (61) 886 33 00',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Raciborzu',
        city: 'Racibórz',
        address: 'ul. Sienkiewicza 3 A',
        latitude: 50.0920,
        longitude: 18.2190,
        phone: 'tel. (32) 418 15 92',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Radomiu',
        city: 'Radom',
        address: 'ul. Limanowskiego 42',
        latitude: 51.4027,
        longitude: 21.1471,
        phone: 'tel. (48) 340 05 20',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Rzeszowie',
        city: 'Rzeszów',
        address: 'ul. Wierzbowa 14',
        latitude: 50.0412,
        longitude: 21.9991,
        phone: 'tel. (17) 867 20 30',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Słupsku',
        city: 'Słupsk',
        address: 'ul. Szarych Szeregów 21',
        latitude: 54.4641,
        longitude: 17.0285,
        phone: 'tel. (59) 842 20 21',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Szczecinie',
        city: 'Szczecin',
        address: 'al. Wojska Polskiego 80/82',
        latitude: 53.4285,
        longitude: 14.5528,
        phone: 'tel. (91) 424 36 00',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Wałbrzychu',
        city: 'Wałbrzych',
        address: 'ul. Chrobrego 31',
        latitude: 50.7714,
        longitude: 16.2845,
        phone: 'tel. (74) 664 63 10',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Warszawie',
        city: 'Warszawa',
        address: 'ul. Saska 63/75',
        latitude: 52.2394,
        longitude: 21.0536,
        phone: 'tel. (22) 514 60 00',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK we Wrocławiu',
        city: 'Wrocław',
        address: 'ul. Czerwonego Krzyża 5-9',
        latitude: 51.1079,
        longitude: 17.0385,
        phone: 'tel. (71) 371 58 10',
      ),
      BloodCenterSyncInput(
        name: 'RCKiK w Zielonej Górze',
        city: 'Zielona Góra',
        address: 'ul. Wazów 42',
        latitude: 51.9356,
        longitude: 15.5062,
        phone: 'tel. (68) 329 83 60',
      ),
      BloodCenterSyncInput(
        name: 'WCKiK MON',
        city: 'Warszawa',
        address: 'ul. Szaserów 128',
        latitude: 52.2480,
        longitude: 21.0823,
        phone: 'tel. 261 816 716',
      ),
      BloodCenterSyncInput(
        name: 'CKiK MSWiA',
        city: 'Warszawa',
        address: 'ul. Wołoska 137',
        latitude: 52.1935,
        longitude: 20.9957,
        phone: 'tel. (22) 508 13 12',
      ),
    ]);
  }

  static double get defaultAnnualIncomePln => _defaultAnnualIncomePln;
}
