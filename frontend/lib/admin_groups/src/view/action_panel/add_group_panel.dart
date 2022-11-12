import 'package:degree_app/admin_groups/admin_groups.dart';

class AddGroupActionPanel extends StatelessWidget {
  const AddGroupActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final nameGroup = TextEditingController();
    final specialityGroup = TextEditingController();
    final courseGroup = TextEditingController();
    final numberSubgroupGroup = TextEditingController();

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
      actions: [
        ActionPanelItem(
          icon: Icons.add,
          onTap: () {
            context
                .read<GroupPanelCubit>()
                .addGroup(
                  name: nameGroup.text,
                  specialityName: specialityGroup.text,
                  course: int.parse(courseGroup.text),
                  subgroupsCount: int.parse(numberSubgroupGroup.text),
                )
                .then(
                  (value) => groupsList.getGroups(),
                );
          },
        ),
      ],
    );
  }
}
