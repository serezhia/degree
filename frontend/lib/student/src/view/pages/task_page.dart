import 'package:degree_app/student/src/cubit/pages/task/task_page_cubit.dart';
import 'package:degree_app/student_task/src/view/page/task_page.dart';
import 'package:degree_app/student_task/src/cubit/page/tasks_page_cubit.dart';

import '../../../student.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              ToggleDegree(
                items: [
                  ToggleItem(lable: 'Текущие'),
                  ToggleItem(lable: 'Выполненные'),
                ],
                currentIndex: context.watch<TaskPageCubit>().currentIndex,
                onTap: (index) {
                  context.read<TaskPageCubit>().changeIndex(index);
                  if (index == 0) {
                    context.read<TasksPageCubit>().getUncompletedTasks();
                  } else {
                    context.read<TasksPageCubit>().getCompletedTasks();
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          TaskList(),
        ],
      );
}
