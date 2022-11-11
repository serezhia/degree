part of 'notification_panel_cubit.dart';

abstract class NotificationPanelState extends Equatable {
  const NotificationPanelState();

  @override
  List<Object> get props => [];
}

class InitialNotificationPanelState extends NotificationPanelState {}

class EmptyNotificationPanelState extends NotificationPanelState {}

class LoadingNotificationPanelState extends NotificationPanelState {}

class LoadedNotificationPanelState extends NotificationPanelState {
  final List<Notification> notifications;

  const LoadedNotificationPanelState(this.notifications);

  @override
  List<Object> get props => [notifications];
}

class ErrorNotificationPanelState extends NotificationPanelState {
  final String message;

  const ErrorNotificationPanelState({required this.message});

  @override
  List<Object> get props => [message];
}
