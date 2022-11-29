import 'package:degree_app/admin_groups/admin_groups.dart';

class EditGroupActionPanel extends StatelessWidget {
  const EditGroupActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final group = context.read<GroupPanelCubit>().state.props[0] as Group;
    final nameGroup = TextEditingController()..text = group.name;
    final specialityGroup = TextEditingController()
      ..text = group.speciality.name;
    final courseGroup = TextEditingController()..text = group.course.toString();
    final numberSubgroupGroup = TextEditingController()
      ..text = group.subgroups!.length.toString(); // Исправить нулл

    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context
              .read<ActionPanelCubit>()
              .closePanel(context.read<ActionPanelCubit>().state);
        },
      ),
      title: 'Изменить группу',
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
                    TextFieldDegree(
                      textEditingController: specialityGroup,
                      textFieldText: 'Специальность',
                      obscureText: false,
                      maxlines: 1,
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
      actions: const [
        // ActionPanelItem(
        //   icon: Icons.add,
        //   onTap: () {
        //     context
        //         .read<GroupPanelCubit>()
        //         .editGroup(
        //           Group(
        //             id: group.id,
        //             name: nameGroup.text,
        //             speciality: Speciality(
        //               id: group.speciality.id,
        //               name: specialityGroup.text,
        //             ),
        //             course: int.parse(courseGroup.text),
        //             subgroups: group.subgroups,
        //           ),
        //         )
        //         .then(
        //           (value) => groupsList.getGroups(),
        //         );
        //   },
        // ),
      ],
    );
  }
}
