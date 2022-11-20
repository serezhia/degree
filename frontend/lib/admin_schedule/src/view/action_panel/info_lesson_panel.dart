import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin_schedule/src/cubit/action_panel/lesson_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';

class InfoLessonActionPanel extends StatelessWidget {
  const InfoLessonActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final lesson =
        (context.read<LessonPanelCubit>().state as InfoLessonPanelState).lesson;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Информация о уроке',
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
                    Text(
                      'lessonId: ${lesson.id}',
                    ),
                    Text(
                      'Дата: ${lesson.date}',
                    ),
                    Text(
                      'Предмет: ${lesson.subject.name}',
                    ),
                    Text(
                      'Преподаватель: ${lesson.teacher.fullName}',
                    ),
                    Text(
                      'Кабинет: ${lesson.cabinet}',
                    ),
                    Text(
                      'Тип: ${lesson.lessonType.name}',
                    ),
                    Text(
                      'Номер пары: ${lesson.numberLesson}',
                    ),
                    if (lesson.group != null)
                      Text(
                        'Группа: ${lesson.group!.name}',
                      ),
                    if (lesson.subgroup != null)
                      Text(
                        'Подгруппа: ${lesson.subgroup!.name}',
                      ),
                    if (lesson.student != null)
                      Text(
                        '''Студент: ${lesson.student!.group.name} ${lesson.student!.fullName}''',
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
