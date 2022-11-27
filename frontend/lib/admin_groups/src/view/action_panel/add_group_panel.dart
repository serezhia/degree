// ignore_for_file: use_build_context_synchronously

import 'package:degree_app/admin_groups/admin_groups.dart';
import 'package:degree_app/degree_ui/inputform/dropdown_text_field.dart';

class AddGroupActionPanel extends StatelessWidget {
  const AddGroupActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final nameGroup = TextEditingController();
    final specialityGroup = TextEditingController();
    final courseGroup = TextEditingController();
    final numberSubgroupGroup = TextEditingController();

    Future<List<DropDownItemDegree>> getItemsSpeciality() async {
      final cubit = context.read<GroupPanelCubit>();
      final specialities = await cubit.getSpecialitiesForField();
      return specialities
          .map(
            (e) => DropDownItemDegree(
              value: e,
              text: e.name,
            ),
          )
          .toList();
    }

    DropDownItemDegree? pickedSpeciality;

    final groupsList = context.read<GroupsPageCubit>();
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context
              .read<ActionPanelCubit>()
              .closePanel(context.read<ActionPanelCubit>().state);
        },
      ),
      title: 'Добавить группу',
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
                      textEditingController: nameGroup,
                      textFieldText: 'Название группы',
                      obscureText: false,
                      maxlines: 1,
                    ),
                    DropDownTextFieldDegree(
                      controller: specialityGroup,
                      nameField: 'Специальность',
                      getItems: getItemsSpeciality,
                      pickedItem: pickedSpeciality,
                      onTapItem: (value) {
                        specialityGroup.text = value.text;
                        pickedSpeciality = DropDownItemDegree(
                          value: value.value,
                          text: value.text,
                        );
                      },
                      createItem: () {
                        context
                            .read<GroupPanelCubit>()
                            .createSpecialityForField(specialityGroup.text);
                      },
                      deleteItem: (value) {
                        context
                            .read<GroupPanelCubit>()
                            .deleteSpecialityForField(
                              (value.value as Speciality).id,
                            );
                      },
                    ),
                    TextFieldDegree(
                      textEditingController: courseGroup,
                      textFieldText: 'Номер курса',
                      obscureText: false,
                      maxlines: 1,
                    ),
                    TextFieldDegree(
                      textEditingController: numberSubgroupGroup,
                      textFieldText: 'Количество подгрупп',
                      obscureText: false,
                      maxlines: 1,
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
          onTap: () async {
            final subgroups =
                await context.read<GroupPanelCubit>().createSubgroups(
                      nameGroup.text,
                      int.parse(numberSubgroupGroup.text),
                    );
            await context.read<GroupPanelCubit>().addGroup(
                  name: nameGroup.text,
                  speciality: pickedSpeciality!.value as Speciality,
                  course: int.parse(courseGroup.text),
                  subgroups: subgroups,
                );

            await groupsList.getGroups();
          },
        ),
      ],
    );
  }
}
