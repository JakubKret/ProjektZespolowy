import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/notification_log_table.dart';

part 'notification_log_dao.g.dart';

@DriftAccessor(tables: [NotificationLogTable])
class NotificationLogDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationLogDaoMixin {
  NotificationLogDao(super.db);

  Future<int> createNotification(NotificationLogTableCompanion notification) {
    return into(notificationLogTable).insert(notification);
  }

  Future<List<NotificationLogTableData>> getNotificationsForDonor(
    int donorProfileId,
  ) {
    return (select(notificationLogTable)
          ..where((t) => t.donorProfileId.equals(donorProfileId))
          ..orderBy([(t) => OrderingTerm.desc(t.scheduledAt)]))
        .get();
  }

  Future<List<NotificationLogTableData>> getPendingNotifications({
    DateTime? asOf,
  }) {
    final cutoff = asOf ?? DateTime.now();
    return (select(notificationLogTable)
          ..where(
            (t) =>
                t.isDismissed.equals(false) &
                t.sentAt.isNull() &
                t.scheduledAt.isSmallerOrEqualValue(cutoff),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.scheduledAt)]))
        .get();
  }

  Future<int> markSent(int id, {DateTime? sentAt}) {
    return (update(notificationLogTable)..where((t) => t.id.equals(id))).write(
      NotificationLogTableCompanion(sentAt: Value(sentAt ?? DateTime.now())),
    );
  }

  Future<int> dismiss(int id) {
    return (update(notificationLogTable)..where((t) => t.id.equals(id))).write(
      const NotificationLogTableCompanion(isDismissed: Value(true)),
    );
  }
}
