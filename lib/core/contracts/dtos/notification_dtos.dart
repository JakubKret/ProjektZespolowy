class SendDueNotificationsRequest {
  final DateTime? asOf;

  const SendDueNotificationsRequest({this.asOf});
}

class SendDueNotificationsResponse {
  final int sentCount;
  final List<int> sentNotificationIds;

  const SendDueNotificationsResponse({
    required this.sentCount,
    required this.sentNotificationIds,
  });
}
