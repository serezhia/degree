import '../../../student_task.dart';

class InfoTaskActionPanel extends StatelessWidget {
  const InfoTaskActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final task =
        (context.read<TaskPanelCubit>().state as InfoTaskPanelState).task;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Информация о задании',
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'День ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '''${task.deadLineDate?.day}.${task.deadLineDate?.month}.${task.deadLineDate?.year}''',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Предмет ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          task.subject.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Преподаватель ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              task.teacher.fullName,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (task.group != null)
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Группа ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                task.group!.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (task.subgroup != null)
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Подгруппа ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                task.subgroup!.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (task.student != null)
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Студент ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    task.student!.fullName,
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        height: 1,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Содержание ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          task.content,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      actions: const [],
    );
  }
}
