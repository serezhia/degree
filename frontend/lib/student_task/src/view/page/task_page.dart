import 'package:degree_app/l10n/l10n.dart';
import 'package:degree_app/student/src/cubit/pages/task/task_page_cubit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../student_task.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<TasksPageCubit, TasksPageState>(
        builder: (context, state) {
          if (state is TasksPageInitial) {
            if (context.read<TaskPageCubit>().currentIndex == 0) {
              context.read<TasksPageCubit>().getUncompletedTasks();
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              context.read<TasksPageCubit>().getCompletedTasks();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else if (state is TasksPageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TasksPageLoaded) {
            return Expanded(
              child: state.tasks.isNotEmpty
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        BoxConstraints maxWightTask() {
                          if (constraints.maxWidth > 1200) {
                            return BoxConstraints(
                              maxWidth: constraints.maxWidth / 4 - 20,
                            );
                          } else if (constraints.maxWidth > 900) {
                            return BoxConstraints(
                              maxWidth: constraints.maxWidth / 3 - 20,
                            );
                          } else if (constraints.maxWidth > 700) {
                            return BoxConstraints(
                              maxWidth: constraints.maxWidth / 2 - 20,
                            );
                          } else {
                            return const BoxConstraints(
                              maxWidth: double.infinity,
                            );
                          }
                        }

                        List<Widget> generateTasks(BoxConstraints constraints) {
                          final tasks = <Widget>[];
                          for (var i = 0; i < state.tasks.length; i++) {
                            tasks.add(
                              TaskCard(
                                task: state.tasks[i],
                                isDone: context
                                        .read<TaskPageCubit>()
                                        .currentIndex ==
                                    1,
                                constraints: maxWightTask(),
                              ),
                            );
                          }
                          return tasks;
                        }

                        if (constraints.maxWidth < 700) {
                          return ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: TaskCard(
                                constraints: const BoxConstraints(
                                  maxWidth: double.infinity,
                                ),
                                isDone: context
                                        .read<TaskPageCubit>()
                                        .currentIndex ==
                                    1,
                                task: state.tasks[index],
                              ),
                            ),
                          );
                        } else {
                          return CustomScrollView(
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Wrap(
                                  runSpacing: 20,
                                  spacing: 20,
                                  children: generateTasks(maxWightTask()),
                                ),
                              )
                            ],
                          );
                        }
                      },
                    )
                  : Center(
                      child: Text(AppLocalizations.of(context).taskListEmpty),
                    ),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context).errorText),
            );
          }
        },
        listener: (context, state) {},
      );
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    required this.task,
    required this.isDone,
    required this.constraints,
    super.key,
  });
  final BoxConstraints constraints;
  final bool isDone;
  final Task task;

  @override
  Widget build(BuildContext context) {
    if (constraints.maxWidth == double.infinity) {
      return Slidable(
        startActionPane: !isDone
            ? ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      context.read<TasksPageCubit>().completeTask(task.id);
                    },
                    backgroundColor: const Color(0xFF000000),
                    foregroundColor: Colors.white,
                    icon: Icons.task,
                    label: AppLocalizations.of(context)
                        .slidableActionCompletedText,
                  ),
                ],
              )
            : null,
        key: ValueKey<Task>(task),
        child: GestureDetector(
          onTap: () {
            context.read<ActionPanelCubit>().openTaskPanel();
            context.read<TaskPanelCubit>().getTask(task.id);
          },
          child: Container(
            width: double.infinity,
            constraints: constraints,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.subject.name,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    task.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          context.read<ActionPanelCubit>().openTaskPanel();
          context.read<TaskPanelCubit>().getTask(task.id);
        },
        child: Container(
          width: double.infinity,
          constraints: constraints,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!isDone)
                      GestureDetector(
                        onTap: () {
                          context.read<TasksPageCubit>().completeTask(task.id);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!isDone)
                      const SizedBox(
                        width: 10,
                      ),
                    Text(
                      task.subject.name,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  task.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
