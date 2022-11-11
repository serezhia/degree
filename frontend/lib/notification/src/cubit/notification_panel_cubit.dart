import 'package:degree_app/notification/notification.dart';

part 'notification_panel_state.dart';

class NotificationPanelCubit extends Cubit<NotificationPanelState> {
  NotificationPanelCubit(this.notificationRepository)
      : super(InitialNotificationPanelState());

  final NotificationRepository notificationRepository;

  Future<void> loadNotifications() async {
    emit(LoadingNotificationPanelState());
    try {
      final notifications = await notificationRepository.getNotifications();
      emit(LoadedNotificationPanelState(notifications));
    } catch (e) {
      emit(ErrorNotificationPanelState(message: e.toString()));
    }
  }
}
