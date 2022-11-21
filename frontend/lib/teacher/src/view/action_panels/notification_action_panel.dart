import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/notification/notification.dart';

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
