import 'package:degree_app/teacher/src/cubit/pages/tasks/task_page_cubit.dart';
import 'package:degree_app/teacher_task/src/cubit/action_panel/task_panel_cubit.dart';
import 'package:degree_app/teacher_task/src/cubit/page/tasks_page_cubit.dart';
import 'package:degree_app/teacher_task/src/view/page/task_page.dart';

import '../../../teacher.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              DateTimePickerDegree(
                currentDate: context.watch<TaskPageCubit>().currentDate,
                currentDateTimeRange:
                    context.watch<TaskPageCubit>().currentRange,
                onDateChanged: (date) {
                  context.read<TaskPageCubit>().setDate(date);
                  context.read<TasksPageCubit>().refreshPage(date);
                },
                onTapBackDateRange: () {
                  context.read<TaskPageCubit>().previosWeek();
                },
                onTapForwardDateRange: context.read<TaskPageCubit>().nextWeek,
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  context.read<ActionPanelCubit>().openTaskPanel();
                  context.read<TaskPanelCubit>().openAddPanel();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          TaskList(),
        ],
      );
}
