// ignore_for_file: lines_longer_than_80_chars

import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin/cubit/pages/schedule/schedule_page_cubit.dart';
import 'package:degree_app/admin_schedule/src/cubit/action_panel/lesson_panel_cubit.dart';
import 'package:degree_app/admin_schedule/src/cubit/page/schedules_page_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SchedulesPageCubit, SchedulesPageState>(
        builder: (context, state) {
          if (state is SchedulesPageInitial) {
            context
                .read<SchedulesPageCubit>()
                .setDate(context.read<SchedulePageCubit>().currentDate);
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SchedulesPageLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SchedulesPageLoaded) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.lessons.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0 ||
                          index != 0 &&
                              '${state.lessons[index - 1].teacher.secondName} ${state.lessons[index - 1].teacher.firstName} ${state.lessons[index - 1].teacher.middleName}' !=
                                  '${state.lessons[index].teacher.secondName} ${state.lessons[index].teacher.firstName} ${state.lessons[index].teacher.middleName}')
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '${state.lessons[index].teacher.secondName} ${state.lessons[index].teacher.firstName} ${state.lessons[index].teacher.middleName}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          context.read<ActionPanelCubit>().openLessonPanel();
                          context.read<LessonPanelCubit>().getLesson(
                                index,
                              );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${state.lessons[index].numberLesson}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.lessons[index].subject.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      if (state.lessons[index].group?.name !=
                                          null)
                                        Text(
                                          '${state.lessons[index].group?.name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      if (state.lessons[index].subgroup?.name !=
                                          null)
                                        Text(
                                          '${state.lessons[index].subgroup?.name}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      if (state.lessons[index].student
                                              ?.firstName !=
                                          null)
                                        Text(
                                          '''${state.lessons[index].student?.secondName} ${state.lessons[index].student?.firstName} ${state.lessons[index].student?.middleName}''',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
