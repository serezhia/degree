// ignore_for_file: one_member_abstracts

import 'package:degree_app/notification/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications();
}
