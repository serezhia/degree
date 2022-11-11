import 'package:degree_app/notification/notification.dart';

class MockNotificationRepository implements NotificationRepository {
  @override
  Future<List<Notification>> getNotifications() =>
      Future.delayed(const Duration(seconds: 1), () {
        final notifications = [
          Notification(
            id: 1,
            title: 'New subject in schedule',
            body: 'New course has been added',
            date: DateTime.now(),
            read: false,
            type: NotificationType.change,
          ),
          Notification(
            id: 2,
            title: 'New course',
            body: 'New course has been added',
            date: DateTime.now(),
            read: false,
            type: NotificationType.change,
          ),
          Notification(
            id: 3,
            title: 'New message',
            body: 'How are you?',
            date: DateTime.now(),
            read: false,
            type: NotificationType.message,
          ),
          Notification(
            id: 4,
            title: 'Admin is online',
            body: 'New course has been added',
            date: DateTime.now(),
            read: false,
            type: NotificationType.other,
          ),
          Notification(
            id: 5,
            title: 'New course',
            body: 'New course has been added',
            date: DateTime.now(),
            read: false,
            type: NotificationType.change,
          ),
        ]..sort((a, b) => b.date.compareTo(a.date));

        return notifications;
      });
}
