import 'dart:convert';

import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../workflow_models.dart';

class NotificationWorkflowService {
  final AppDatabase _db;

  NotificationWorkflowService(this._db);

  Future<int> scheduleEligibilityNotifications({
    required int donorProfileId,
    required DateTime nextEligibleAt,
    required String reason,
  }) {
    return _db.notificationLogDao.createNotification(
      NotificationLogTableCompanion.insert(
        donorProfileId: donorProfileId,
        notificationType: 'eligibility',
        scheduledAt: nextEligibleAt,
        payloadJson: Value(
          jsonEncode({
            'reason': reason,
            'nextEligibleAt': nextEligibleAt.toIso8601String(),
          }),
        ),
      ),
    );
  }

  Future<SentNotificationsResult> sendDueNotifications({DateTime? asOf}) async {
    final pending = await _db.notificationLogDao.getPendingNotifications(asOf: asOf);
    final sentIds = <int>[];
    for (final n in pending) {
      await _db.notificationLogDao.markSent(n.id, sentAt: asOf ?? DateTime.now());
      sentIds.add(n.id);
    }
    return SentNotificationsResult(
      sentCount: sentIds.length,
      sentNotificationIds: sentIds,
    );
  }

  Future<int> dismissNotification(int notificationId) {
    return _db.notificationLogDao.dismiss(notificationId);
  }

  Future<int> rescheduleNotification({
    required int notificationId,
    required DateTime scheduledAt,
  }) {
    return (_db.update(_db.notificationLogTable)
          ..where((t) => t.id.equals(notificationId)))
        .write(
      NotificationLogTableCompanion(scheduledAt: Value(scheduledAt)),
    );
  }

  Future<int> createBadgeNotification({
    required int donorProfileId,
    required List<int> awardedBadgeIds,
    required int donationId,
  }) {
    return _db.notificationLogDao.createNotification(
      NotificationLogTableCompanion.insert(
        donorProfileId: donorProfileId,
        notificationType: 'badge_awarded',
        scheduledAt: DateTime.now(),
        payloadJson: Value(
          jsonEncode({
            'badgeIds': awardedBadgeIds,
            'donationId': donationId,
          }),
        ),
      ),
    );
  }

  Future<int> createRiskNotification({
    required int donorProfileId,
    required int morphologyResultId,
    double? hgbGDl,
    double? ferritinNgMl,
  }) {
    return _db.notificationLogDao.createNotification(
      NotificationLogTableCompanion.insert(
        donorProfileId: donorProfileId,
        notificationType: 'morphology_risk',
        scheduledAt: DateTime.now(),
        payloadJson: Value(
          jsonEncode({
            'morphologyResultId': morphologyResultId,
            'hgbGDl': hgbGDl,
            'ferritinNgMl': ferritinNgMl,
          }),
        ),
      ),
    );
  }
}
