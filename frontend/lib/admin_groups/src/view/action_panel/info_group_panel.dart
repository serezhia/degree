import '../../../admin_groups.dart';

class InfoGroupActionPanel extends StatelessWidget {
  const InfoGroupActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final group = context.read<GroupPanelCubit>().state.props[0] as Group;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Информация о группе',
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
                      'groupId: ${group.id}',
                    ),
                    Text(
                      'Название группы: ${group.name}',
                    ),
                    Text(
                      'Курс: ${group.course}',
                    ),
                    Text(
                      'Специальность: ${group.speciality.name}',
                    ),
                    if (group.subgroups != null && group.subgroups!.isNotEmpty)
                      for (var subgroup in group.subgroups!)
                        Text(
                          'Подгруппа: ${subgroup.name}',
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
          icon: Icons.delete,
          onTap: () {
            context.read<GroupPanelCubit>().deleteGroup(group.id);
            context.read<ActionPanelCubit>().closePanel(
                  context.read<ActionPanelCubit>().state,
                );
            context.read<GroupsPageCubit>().getGroups();
          },
        ),
        ActionPanelItem(
          icon: Icons.edit,
          onTap: () {
            context.read<GroupPanelCubit>().openEditPanel(group);
          },
        ),
      ],
    );
  }
}
