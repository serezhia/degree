// ignore_for_file: prefer_expression_function_bodies

import 'package:degree_app/degree_ui/inputform/dropdown_text_field.dart';

import 'package:degree_app/teacher_task/src/cubit/action_panel/task_panel_cubit.dart';
import 'package:intl/intl.dart';

import '../../../teacher_task.dart';

class AddTaskActionPanel extends StatefulWidget {
  const AddTaskActionPanel({super.key});

  @override
  State<AddTaskActionPanel> createState() => _AddTaskActionPanelState();
}

class _AddTaskActionPanelState extends State<AddTaskActionPanel> {
  final subjectController = TextEditingController();
  final groupController = TextEditingController();
  final subgroupController = TextEditingController();
  final studentController = TextEditingController();
  final contentController = TextEditingController();

  int currentIndex = 0;

  int currentIndexDeadline = 0;

  DateTime? pickedDate;

  Future<List<DropDownItemDegree>> getItemsSubject() async {
    final cubit = context.read<TaskPanelCubit>();
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

  Future<List<DropDownItemDegree>> getItemsStudent() async {
    final cubit = context.read<TaskPanelCubit>();
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

  Future<List<DropDownItemDegree>> getItemsSubgroup() async {
    final cubit = context.read<TaskPanelCubit>();
    final groups = await cubit.getGroupsForField();
    final subgroups = <Subgroup>[];
    for (final group in groups) {
      final groupSubgroups = group.subgroups;
      if (groupSubgroups != null) {
        subgroups.addAll(groupSubgroups);
      }
    }
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

  Future<List<DropDownItemDegree>> getItemsGroup() async {
    final cubit = context.read<TaskPanelCubit>();
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

  @override
  Widget build(BuildContext context) {
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context
              .read<ActionPanelCubit>()
              .closePanel(context.read<ActionPanelCubit>().state);
        },
      ),
      title: 'Добавить задание',
      body: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropDownTextFieldDegree(
                controller: subjectController,
                nameField: 'Предмет',
                getItems: getItemsSubject,
                onTapItem: (value) {
                  subjectController.text = value.text;
                  pickedSubject = DropDownItemDegree(
                    value: value.value,
                    text: value.text,
                  );
                },
                pickedItem: pickedSubject,
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
                      ToggleItem(
                        lable: 'Студенту',
                      ),
                    ],
                    currentIndex: currentIndex,
                    onTap: (value) {
                      currentIndex = value;

                      setState(() {});
                    },
                  ),
                ],
              ),
              if (currentIndex == 0)
                DropDownTextFieldDegree(
                  controller: groupController,
                  nameField: 'Группа',
                  getItems: getItemsGroup,
                  onTapItem: (value) {
                    groupController.text = value.text;
                    pickedGroup = DropDownItemDegree(
                      value: value.value,
                      text: value.text,
                    );

                    pickedStudent = null;
                    studentController.text = '';
                    pickedSubgroup = null;
                    subgroupController.text = '';
                  },
                  pickedItem: pickedGroup,
                ),
              if (currentIndex == 1)
                DropDownTextFieldDegree(
                  controller: subgroupController,
                  nameField: 'Подгруппа',
                  getItems: getItemsSubgroup,
                  onTapItem: (value) {
                    subgroupController.text = value.text;
                    pickedSubgroup = DropDownItemDegree(
                      value: value.value,
                      text: value.text,
                    );

                    pickedGroup = null;
                    groupController.text = '';
                    pickedStudent = null;
                    studentController.text = '';
                  },
                  pickedItem: pickedSubgroup,
                ),
              if (currentIndex == 2)
                DropDownTextFieldDegree(
                  controller: studentController,
                  nameField: 'Студент',
                  getItems: getItemsStudent,
                  onTapItem: (value) {
                    studentController.text = value.text;
                    pickedStudent = DropDownItemDegree(
                      value: value.value,
                      text: value.text,
                    );

                    pickedGroup = null;
                    groupController.text = '';
                    pickedSubgroup = null;
                    subgroupController.text = '';
                  },
                  pickedItem: pickedStudent,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleDegree(
                    items: [
                      ToggleItem(
                        lable: 'Следующий урок',
                      ),
                      ToggleItem(
                        lable: 'По дате',
                      ),
                    ],
                    currentIndex: currentIndexDeadline,
                    onTap: (value) {
                      currentIndexDeadline = value;

                      setState(() {});
                    },
                  ),
                ],
              ),
              if (currentIndexDeadline == 1)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Дата',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (date != null) {
                            setState(() {
                              pickedDate = date;
                            });
                          }
                        },
                        child: Text(
                          pickedDate != null
                              ? DateFormat('dd.MM.yyyy').format(pickedDate!)
                              : 'Выбрать',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                ),
              TextFieldDegree(
                textEditingController: contentController,
                textFieldText: 'Содержание',
                obscureText: false,
                maxlines: 12,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ActionPanelItem(
          icon: Icons.add,
          onTap: () {
            context.read<TaskPanelCubit>().addTask(
                  subject: pickedSubject!.value as Subject,
                  content: contentController.text,
                  deadLineType: currentIndexDeadline == 0
                      ? DeadLineType.lesson
                      : DeadLineType.date,
                  deadLineDate: pickedDate,
                  group: pickedGroup?.value as Group?,
                  subgroup: pickedSubgroup?.value as Subgroup?,
                  student: pickedStudent?.value as Student?,
                );
          },
        ),
      ],
    );
  }
}

// class TextFieldTagsDegree extends StatefulWidget {
//   const TextFieldTagsDegree({super.key});

//   @override
//   State<TextFieldTagsDegree> createState() => _TextFieldTagsDegreeState();
// }

// class _TextFieldTagsDegreeState extends State<TextFieldTagsDegree> {
//   final TextEditingController _controller = TextEditingController();

//   final tags = <Widget>[];

//   void _addTag(String tag) {
//     setState(() {
//       tags.add(
//         TagWidget(
//           tag: Tag(
//             id: tags.length,
//             name: tag,
//           ),
//           onTap: () => _removeTag(tag),
//         ),
//       );
//       _controller.clear();
//     });
//   }

//   void _removeTag(String tag) {
//     setState(() {
//       tags.removeWhere(
//         (element) => element is TagWidget && element.tag.name == tag,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) => Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300, width: 1.5),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Wrap(
//           spacing: 10,
//           runSpacing: 10,
//           children: [
//             ...tags,
//             ConstrainedBox(
//               constraints: const BoxConstraints(
//                 minWidth: 30,
//                 maxWidth: 125,
//                 maxHeight: 20,
//               ),
//               child: Center(
//                 child: TextField(
//                   style: const TextStyle(
//                     height: 1.5,
//                   ),
//                   maxLines: 1,
//                   controller: _controller,
//                   onEditingComplete: () {
//                     if (_controller.text.isNotEmpty) {
//                       _addTag(_controller.text.toLowerCase());
//                     }
//                   },
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
// }

// class Tag {
//   final int id;
//   final String name;

//   Tag({
//     required this.id,
//     required this.name,
//   });
// }

// class TagWidget extends StatelessWidget {
//   const TagWidget({
//     required this.tag,
//     required this.onTap,
//     super.key,
//   });

//   final Tag tag;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       padding: const EdgeInsets.all(5),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             tag.name,
//             style: const TextStyle(
//               height: 1,
//               color: Colors.white,
//               fontFamily: 'Roboto',
//               fontFeatures: [FontFeature.enable('smcp')],
//             ),
//           ),
//           const SizedBox(width: 5),
//           GestureDetector(
//             onTap: onTap,
//             child: const Icon(
//               Icons.close,
//               color: Colors.white,
//               size: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
