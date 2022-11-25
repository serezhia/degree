import 'package:degree_app/teacher_task/src/cubit/action_panel/task_panel_cubit.dart';
import 'package:degree_app/teacher_task/src/view/action_panel/info_task_panel.dart';
import 'package:degree_app/teacher_task/src/view/action_panel/loading_task_panel.dart';

import '../../../teacher.dart';

class TaskActionPanel extends StatelessWidget {
  const TaskActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TaskPanelCubit, TaskPanelState>(
        builder: (context, state) {
          if (state is InfoTaskPanelState) {
            return const InfoTaskActionPanel();
          } else {
            return const LoadingTaskActionPanel();
          }
        },
      );
}
