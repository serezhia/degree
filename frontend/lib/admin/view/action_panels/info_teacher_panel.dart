import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';

class InfoTeacherActionPanel extends StatelessWidget {
  const InfoTeacherActionPanel({super.key});

  @override
  Widget build(BuildContext context) => ActionPanel(
        leading: ActionPanelItem(
          icon: Icons.arrow_back,
          onTap: () {
            context.read<ActionPanelCubit>().closePanel();
          },
        ),
        title: 'Информация о студенте',
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: const [],
                  ),
                ),
              ),
            )
          ],
        ),
        actions: [
          ActionPanelItem(
            icon: Icons.save,
            onTap: () {},
          ),
        ],
      );
}
