// ignore_for_file: lines_longer_than_80_chars

import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/notification/notification.dart';
import '../../src/model/notification_model.dart' as model;

class LoadedNotificationActionPanel extends StatelessWidget {
  const LoadedNotificationActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = context.read<NotificationPanelCubit>().state.props[0]
        as List<model.Notification>;
    final actionPanelState = context.read<ActionPanelCubit>().state;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.close,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(actionPanelState);
        },
      ),
      title: 'Уведомления',
      body: ColoredBox(
        color: Colors.white,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) => SizedBox(
            height: 100,
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          const Icon(Icons.notifications, color: Colors.white),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notifications[index].title,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                notifications[index].body,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      '${notifications[index].date.day.toString()}.${notifications[index].date.month.toString()}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
