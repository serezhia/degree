import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/notification/notification.dart';
import 'package:degree_app/notification/src/cubit/notification_panel_cubit.dart';
import 'package:degree_app/notification/src/view/loaded_notification_panel.dart';
import 'package:degree_app/notification/src/view/loading_notification_panel.dart';

class NotificationActionPanel extends StatelessWidget {
  const NotificationActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<NotificationPanelCubit, NotificationPanelState>(
        builder: (context, state) {
          if (state is LoadedNotificationPanelState) {
            return const LoadedNotificationActionPanel();
          } else {
            return const LoadingNotificationActionPanel();
          }
        },
      );
}
