import 'package:degree_app/student/src/view/action_panels/lesson_action_panel.dart';
import 'package:degree_app/student/src/view/action_panels/task_action_panel.dart';

import '../../../student.dart';

class ActionPanelBuilder extends StatelessWidget {
  const ActionPanelBuilder({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActionPanelCubit, ActionPanelState>(
        builder: (context, state) {
          if (state is ProfileActionPanelState) {
            return const ProfileActionPanel();
          } else if (state is LessonActionPanelState) {
            return const LessonActionPanel();
          } else if (state is TaskActionPanelState) {
            return const TaskActionPanel();
          } else {
            return const SizedBox();
          }
        },
      );
}
