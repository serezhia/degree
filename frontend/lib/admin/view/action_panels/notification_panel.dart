import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';

class NotificationActionPanel extends StatelessWidget {
  const NotificationActionPanel({super.key});

  @override
  Widget build(BuildContext context) => ActionPanel(
        leading: ActionPanelItem(
          icon: Icons.close,
          onTap: () {
            context.read<ActionPanelCubit>().closePanel();
          },
        ),
        title: 'Уведомления',
        body: const CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: ColoredBox(
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
