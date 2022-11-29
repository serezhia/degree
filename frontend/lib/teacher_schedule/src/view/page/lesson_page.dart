// ignore_for_file: prefer_expression_function_bodies

import 'package:degree_app/teacher/src/cubit/pages/schedule/schedule_page_cubit.dart';
import 'package:degree_app/teacher/teacher.dart';

import 'package:intl/intl.dart';

class LessonsList extends StatelessWidget {
  const LessonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SchedulesPageCubit, SchedulesPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SchedulesPageInitial) {
          context
              .read<SchedulesPageCubit>()
              .setWeek(context.read<SchedulePageCubit>().currentRange);
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SchedulesPageLoaded) {
          List<Widget> generateLessonsDay(BoxConstraints constraints) {
            final lessonsDay = <Widget>[];
            for (var i = 0; i < state.lessons.length; i++) {
              final lessons = state.lessons
                  .where(
                    (element) =>
                        element.date.day ==
                        DateTime.now().add(Duration(days: i)).day,
                  )
                  .toList();
              if (lessons.isNotEmpty) {
                lessonsDay.add(
                  ConstrainedBox(
                    constraints: constraints,
                    child: LessonsDay(
                      lessons: lessons,
                    ),
                  ),
                );
              }
            }
            return lessonsDay;
          }

          return state.lessons.isEmpty
              ? const Center(
                  child: Text('Нет занятий'),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    BoxConstraints maxWightDay() {
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
                        return const BoxConstraints();
                      }
                    }

                    return CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: generateLessonsDay(maxWightDay()),
                          ),
                        )
                      ],
                    );
                  },
                );
        } else if (state is SchedulesPageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('Page not found'),
          );
        }
      },
    );
  }
}

class LessonsDay extends StatelessWidget {
  const LessonsDay({required this.lessons, super.key});

  final List<Lesson> lessons;

  @override
  Widget build(BuildContext context) {
    lessons.sort((a, b) => a.numberLesson.compareTo(b.numberLesson));
    return Container(
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '''${DateFormat.E().format(lessons.first.date)}, ${DateFormat.d().format(lessons.first.date)} ${DateFormat.MMM().format(lessons.first.date)}''',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          for (var lesson in lessons)
            Column(
              children: [
                LessonWidget(lesson: lesson),
                if (lesson != lessons.last)
                  const Divider(
                    height: 20,
                    thickness: 1,
                  )
                else
                  const SizedBox(),
              ],
            ),
        ],
      ),
    );
  }
}

class LessonWidget extends StatelessWidget {
  const LessonWidget({
    required this.lesson,
    super.key,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ActionPanelCubit>().openLessonPanel();
        context.read<LessonPanelCubit>().getLesson(lesson.id);
      },
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                    child: Text(
                      ' ${lesson.numberLesson}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.group?.name ??
                              lesson.subgroup?.name ??
                              '''${lesson.student!.group.name} ${lesson.student!.fullName}''',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          lesson.subject.name,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: const Color(0xFF808080),
                                  ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 50,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(lesson.cabinet.number.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
