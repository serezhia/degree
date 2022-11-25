import 'package:degree_app/teacher/src/cubit/pages/tasks/task_page_cubit.dart';
import 'package:degree_app/teacher_task/src/cubit/action_panel/task_panel_cubit.dart';
import 'package:degree_app/teacher_task/src/cubit/page/tasks_page_cubit.dart';

import '../../../teacher_task.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<TasksPageCubit, TasksPageState>(
        builder: (context, state) {
          if (state is TasksPageInitial) {
            context
                .read<TasksPageCubit>()
                .setDate(context.read<TaskPageCubit>().currentDate);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TasksPageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TasksPageLoaded) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.tasks.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: TaskCard(
                    task: state.tasks[index],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Ошибка'),
            );
          }
        },
        listener: (context, state) {},
      );
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          context.read<ActionPanelCubit>().openTaskPanel();
          context.read<TaskPanelCubit>().getTask(task.id);
        },
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  task.group?.name ??
                      task.subgroup?.name ??
                      task.student?.fullName ??
                      'Неизвестно',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  task.subject.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
