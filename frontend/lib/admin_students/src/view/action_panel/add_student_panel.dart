import 'dart:developer';

import 'package:degree_app/admin_groups/admin_groups.dart';
import 'package:degree_app/degree_ui/inputform/dropdown_text_field.dart';

import '../../../admin_students.dart';

class AddStudentActionPanel extends StatelessWidget {
  const AddStudentActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final firstName = TextEditingController();
    final secondName = TextEditingController();
    final middleName = TextEditingController();
    final groupController = TextEditingController();
    final subgroupController = TextEditingController();
    final studentsList = context.read<StudentsPageCubit>();
    Future<List<DropDownItemDegree>> getItemsGroup() async {
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

    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context
              .read<ActionPanelCubit>()
              .closePanel(context.read<ActionPanelCubit>().state);
        },
      ),
      title: 'Добавить студента',
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
                    TextFieldDegree(
                      textEditingController: secondName,
                      textFieldText: 'Фамилия',
                      obscureText: false,
                      maxlines: 1,
                    ),
                    TextFieldDegree(
                      textEditingController: firstName,
                      textFieldText: 'Имя',
                      obscureText: false,
                      maxlines: 1,
                    ),
                    TextFieldDegree(
                      textEditingController: middleName,
                      textFieldText: 'Отчество',
                      obscureText: false,
                      maxlines: 1,
                    ),
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
                        log('pickedGroup ${pickedGroup?.text}');
                      },
                      pickedItem: pickedGroup,
                    ),
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
                        log('pickedSubgroup ${pickedSubgroup?.text}');
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
            context
                .read<StudentPanelCubit>()
                .addStudent(
                  firstName: firstName.text,
                  secondName: secondName.text,
                  middleName: middleName.text,
                  group: pickedGroup!.value as Group,
                  subgroup: pickedSubgroup!.value as Subgroup,
                )
                .then(
                  (value) => studentsList.getStudents(),
                );
          },
        ),
      ],
    );
  }
}
