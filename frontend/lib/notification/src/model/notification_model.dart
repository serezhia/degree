import 'package:degree_app/notification/notification.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class Notification {
  final int id;
  final String title;
  final String body;
  final DateTime date;
  final bool read;
  final NotificationType type;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.read,
    required this.type,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

enum NotificationType {
  @JsonValue('change')
  change,
  @JsonValue('message')
  message,
  @JsonValue('task')
  task,
  @JsonValue('other')
  other,
}
