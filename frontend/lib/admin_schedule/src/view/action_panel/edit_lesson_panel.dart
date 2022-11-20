import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';

class EditLessonActionPanel extends StatelessWidget {
  const EditLessonActionPanel({super.key});

  @override
  Widget build(BuildContext context) => ActionPanel(
        leading: ActionPanelItem(
          icon: Icons.arrow_back,
          onTap: () {
            context.read<ActionPanelCubit>().closePanel(
                  context.read<ActionPanelCubit>().state,
                );
          },
        ),
        title: 'Редактирование урока',
        body: const CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Colors.white,
              ),
            )
          ],
        ),
        actions: const [],
      );
}
