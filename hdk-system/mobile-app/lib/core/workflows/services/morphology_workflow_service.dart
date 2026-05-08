import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../workflow_models.dart';
import 'notification_workflow_service.dart';

class MorphologyWorkflowService {
  final AppDatabase _db;
  final NotificationWorkflowService _notificationWorkflow;

  MorphologyWorkflowService(this._db, this._notificationWorkflow);

  Future<MorphologyRiskResult> saveMorphologyResultAndEvaluateRisk({
    required int donorProfileId,
    required DateTime resultDate,
    int? donationId,
    double? hgbGDl,
    double? ferritinNgMl,
    bool isVerified = false,
  }) async {
    return _db.transaction(() async {
      final morphologyResultId = await _db.morphologyResultsDao.createResult(
        MorphologyResultsTableCompanion.insert(
          donorId: donorProfileId,
          donationId: Value(donationId),
          resultDate: resultDate,
          hgbGDl: Value(hgbGDl),
          ferritinNgMl: Value(ferritinNgMl),
          isVerified: Value(isVerified),
        ),
      );

      final isRiskDetected =
          (hgbGDl != null && hgbGDl < 12.0) ||
          (ferritinNgMl != null && ferritinNgMl < 20.0);

      int? notificationId;
      if (isRiskDetected) {
        notificationId = await _notificationWorkflow.createRiskNotification(
          donorProfileId: donorProfileId,
          morphologyResultId: morphologyResultId,
          hgbGDl: hgbGDl,
          ferritinNgMl: ferritinNgMl,
        );
      }

      return MorphologyRiskResult(
        morphologyResultId: morphologyResultId,
        isRiskDetected: isRiskDetected,
        notificationId: notificationId,
      );
    });
  }

  Future<int> verifyMorphologyResult(int morphologyResultId) {
    return (_db.update(_db.morphologyResultsTable)
          ..where((t) => t.id.equals(morphologyResultId)))
        .write(
      const MorphologyResultsTableCompanion(isVerified: Value(true)),
    );
  }

  Future<int> linkMorphologyToDonation({
    required int morphologyResultId,
    required int donationId,
  }) {
    return (_db.update(_db.morphologyResultsTable)
          ..where((t) => t.id.equals(morphologyResultId)))
        .write(
      MorphologyResultsTableCompanion(donationId: Value(donationId)),
    );
  }
}
