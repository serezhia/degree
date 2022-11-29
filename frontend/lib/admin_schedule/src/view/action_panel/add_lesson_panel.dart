import 'dart:developer';

import 'package:degree_app/admin/cubit/pages/schedule/schedule_page_cubit.dart';
import 'package:degree_app/admin_schedule/admin_schedule.dart';
import 'package:degree_app/admin_schedule/src/cubit/page/schedules_page_cubit.dart';
import 'package:degree_app/admin_schedule/src/model/cabinet_model.dart';
import 'package:degree_app/degree_ui/inputform/dropdown_text_field.dart';
import 'package:degree_app/degree_ui/utils/datetime_utils/date_time_utils.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../cubit/action_panel/lesson_panel_cubit.dart';

class AddLessonActionPanel extends StatefulWidget {
  const AddLessonActionPanel({super.key});

  @override
  State<AddLessonActionPanel> createState() => _AddLessonActionPanelState();
}

class _AddLessonActionPanelState extends State<AddLessonActionPanel> {
  final teacherController = TextEditingController();
  final subjectController = TextEditingController();
  final lessonNumberController = TextEditingController();
  final lessonTypeController = TextEditingController();
  final cabinetController = TextEditingController();
  final lessonDateController = TextEditingController();
  final lessonGroupController = TextEditingController();
  final lessonSubgroupController = TextEditingController();
  final lessonStudentController = TextEditingController();

  int currentIndex = 0;
  Future<List<DropDownItemDegree>> getItemsLessonTypes() async {
    log('Обновляем список типов урока ');
    final cubit = context.read<LessonPanelCubit>();
    final lessonTypes = await cubit.getLessonTypesForField();
    return lessonTypes
        .map(
          (e) => DropDownItemDegree(
            value: e,
            text: e.name,
          ),
        )
        .toList();
  }

  DropDownItemDegree? pickedLessonType;

  Future<List<DropDownItemDegree>> getItemsSubject() async {
    log('Обновляем списокпредметов ');
    final cubit = context.read<SubjectsPageCubit>();
    final subjects = await cubit.getSubjectsForField();
    return subjects
        .map(
          (e) => DropDownItemDegree(
            value: e,
            text: e.name,
          ),
        )
        .toList();
  }

  DropDownItemDegree? pickedSubject;

  Future<List<DropDownItemDegree>> getItemsTeacher() async {
    log('Обновляем список учителей');
    final cubit = context.read<TeachersPageCubit>();
    final subjects = await cubit.getTeachersForField();
    return subjects
        .map(
          (e) => DropDownItemDegree(
            value: e,
            text: '${e.secondName} ${e.firstName} ${e.middleName ?? ''}',
          ),
        )
        .toList();
  }

  DropDownItemDegree? pickedTeacher;

  Future<List<DropDownItemDegree>> getItemsGroup() async {
    log('Обновляем список групп');
    final cubit = context.read<GroupsPageCubit>();
    final groups = await cubit.getGroupsForField();
    return groups
        .map(
          (e) => DropDownItemDegree(
            value: e,
            text: e.name,
          ),
        )
        .toList();
  }

  DropDownItemDegree? pickedGroup;

  Future<List<DropDownItemDegree>> getItemsCabinet() async {
    log('Обновляем список кабинетов');
    final cubit = context.read<LessonPanelCubit>();
    final cabintes = await cubit.getCabinetsForField();
    return cabintes
        .map(
          (e) => DropDownItemDegree(
            value: e,
            text: e.number.toString(),
          ),
        )
        .toList();
  }

  DropDownItemDegree? pickedCabinet;

  Future<List<DropDownItemDegree>> getItemsSubgroup() async {
    log('Обновляем список подгрупп');
    final cubit = context.read<GroupsPageCubit>();
    final subgroups = await cubit.getSubgroupsForField();

    return subgroups
        .map(
          (e) => DropDownItemDegree(
            value: e,
            text: e.name,
          ),
        )
        .toList();
  }

  DropDownItemDegree? pickedSubgroup;

  Future<List<DropDownItemDegree>> getItemsStudent() async {
    log('Обновляем список студентов');
    final cubit = context.read<StudentsPageCubit>();
    final students = await cubit.getStudentsForField();
    return students
        .map(
          (e) => DropDownItemDegree(
            value: e,
            text:
                '''${e.group.name} ${e.secondName} ${e.firstName} ${e.middleName ?? ''} ''',
          ),
        )
        .toList();
  }

  DropDownItemDegree? pickedStudent;

  @override
  Widget build(BuildContext context) => ActionPanel(
        leading: ActionPanelItem(
          icon: Icons.arrow_back,
          onTap: () {
            context.read<ActionPanelCubit>().closePanel(
                  context.read<ActionPanelCubit>().state,
                );
          },
        ),
        title: 'Добавление урока',
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      DropDownTextFieldDegree(
                        controller: teacherController,
                        nameField: 'Преподаватель',
                        getItems: getItemsTeacher,
                        onTapItem: (value) {
                          teacherController.text = value.text;
                          pickedTeacher = DropDownItemDegree(
                            value: value.value,
                            text: value.text,
                          );
                          final teacher = pickedTeacher?.value as Teacher?;
                          log('pickedTeacher ${teacher?.teacherId}');
                          log('pickedTeacher ${teacher?.firstName}');
                        },
                        pickedItem: pickedTeacher,
                      ),
                      DropDownTextFieldDegree(
                        controller: subjectController,
                        nameField: 'Предмет',
                        getItems: getItemsSubject,
                        createItem: () {
                          log('Сработало добавить предмет');
                          context
                              .read<SubjectPanelCubit>()
                              .addSubject(name: subjectController.text)
                              .then((value) {
                            if (value != null) {
                              pickedSubject = DropDownItemDegree(
                                value: value,
                                text: value.name,
                              );
                            }
                          });
                        },
                        onTapItem: (value) {
                          subjectController.text = value.text;
                          pickedSubject = DropDownItemDegree(
                            value: value.value,
                            text: value.text,
                          );
                          log('pickedSubject ${pickedSubject?.text}');
                        },
                        pickedItem: pickedSubject,
                      ),
                      TextFieldDegree(
                        textEditingController: lessonNumberController,
                        textFieldText: 'Номер урока',
                        obscureText: false,
                        maxlines: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                      TextFieldDegree(
                        textEditingController: lessonDateController,
                        textFieldText: 'День',
                        obscureText: false,
                        maxlines: 1,
                        inputFormatters: [
                          DateTextFormatter(),
                        ],
                      ),
                      DropDownTextFieldDegree(
                        controller: lessonTypeController,
                        nameField: 'Тип урока',
                        getItems: getItemsLessonTypes,
                        createItem: () {
                          log('Сработало добавить тип урока');
                          context
                              .read<LessonPanelCubit>()
                              .addLessonType(lessonTypeController.text)
                              .then((value) {
                            pickedLessonType = DropDownItemDegree(
                              value: value,
                              text: value.name,
                            );
                          });
                        },
                        onTapItem: (value) {
                          lessonTypeController.text = value.text;
                          pickedLessonType = DropDownItemDegree(
                            value: value.value,
                            text: value.text,
                          );
                          log('pickedLessonType ${pickedLessonType?.text}');
                        },
                        pickedItem: pickedLessonType,
                      ),
                      DropDownTextFieldDegree(
                        controller: cabinetController,
                        nameField: 'Кабинет',
                        getItems: getItemsCabinet,
                        createItem: () {
                          log('Сработало добавить кабинет');
                          context
                              .read<LessonPanelCubit>()
                              .addCabinet(int.parse(cabinetController.text))
                              .then((value) {
                            pickedCabinet = DropDownItemDegree(
                              value: value,
                              text: value.number.toString(),
                            );
                          });
                        },
                        onTapItem: (value) {
                          cabinetController.text = value.text;
                          pickedCabinet = DropDownItemDegree(
                            value: value.value,
                            text: value.text,
                          );
                          log('pickedCabinet ${pickedCabinet?.text}');
                        },
                        pickedItem: pickedCabinet,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleDegree(
                            items: [
                              ToggleItem(
                                lable: 'Группе',
                              ),
                              ToggleItem(
                                lable: 'Подгруппе',
                              ),
                            ],
                            currentIndex: currentIndex,
                            onTap: (value) {
                              currentIndex = value;
                              log('change index $currentIndex');
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      if (currentIndex == 0)
                        DropDownTextFieldDegree(
                          controller: lessonGroupController,
                          nameField: 'Группа',
                          getItems: getItemsGroup,
                          onTapItem: (value) {
                            lessonGroupController.text = value.text;
                            pickedGroup = DropDownItemDegree(
                              value: value.value,
                              text: value.text,
                            );
                            log('pickedGroup ${pickedGroup?.text}');
                            pickedStudent = null;
                            lessonStudentController.text = '';
                            pickedSubgroup = null;
                            lessonSubgroupController.text = '';
                          },
                          pickedItem: pickedGroup,
                        ),
                      if (currentIndex == 1)
                        DropDownTextFieldDegree(
                          controller: lessonSubgroupController,
                          nameField: 'Подгруппа',
                          getItems: getItemsSubgroup,
                          onTapItem: (value) {
                            lessonSubgroupController.text = value.text;
                            pickedSubgroup = DropDownItemDegree(
                              value: value.value,
                              text: value.text,
                            );
                            log('pickedGroup ${pickedSubgroup?.text}');
                            pickedGroup = null;
                            lessonGroupController.text = '';
                            pickedStudent = null;
                            lessonStudentController.text = '';
                          },
                          pickedItem: pickedSubgroup,
                        ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        actions: [
          ActionPanelItem(
            icon: Icons.add,
            onTap: () {
              final date = DateFormat('d-M-y').parse(lessonDateController.text);
              context.read<LessonPanelCubit>().addLesson(
                    subject: pickedSubject!.value as Subject,
                    numberLesson: int.parse(lessonNumberController.text),
                    date: date,
                    lessonType: pickedLessonType!.value as LessonType,
                    cabinet: pickedCabinet!.value as Cabinet,
                    teacher: pickedTeacher!.value as Teacher,
                    group: pickedGroup?.value as Group?,
                    subgroup: pickedSubgroup?.value as Subgroup?,
                  );
              context
                  .read<SchedulesPageCubit>()
                  .refreshPage(context.read<SchedulePageCubit>().currentDate);
            },
          ),
        ],
      );
}
