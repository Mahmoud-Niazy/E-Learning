abstract class NotificationsRepo {
  Future<List<Map<String,dynamic>>> getAllNotifications();
  Future<void> makeAllNotificationsAsSeen();
  Future<void> makeNotificationAsSeen(String notificationId);
}