import 'package:degree_app/admin/view/pages/entity_page.dart';
import 'package:degree_app/admin_groups/admin_groups.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<GroupsPageCubit, GroupsPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialGroupsPageState) {
            context.read<GroupsPageCubit>().getGroups();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadingGroupsPageState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedGroupsPageState) {
            if (state.groups.isEmpty) {
              return const Expanded(
                child: ColoredBox(
                  color: Color(0xFFFFFFFF),
                  child: Center(
                    child: Text('Список групп пуст'),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  key: context.read<EntitiesState>().listGroupsKey,
                  addAutomaticKeepAlives: false,
                  itemCount: state.groups.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0 ||
                            index != 0 &&
                                state.groups[index - 1].name[0] !=
                                    state.groups[index].name[0])
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              state.groups[index].name[0],
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            context.read<ActionPanelCubit>().openGroupPanel();
                            context
                                .read<GroupPanelCubit>()
                                .getGroup(state.groups[index].id);
                          },
                          child: ColoredBox(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 15,
                              ),
                              child: Row(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.groups[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
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
            }
          } else {
            return Center(
              child: Text('state: $state'),
            );
          }
        },
      );
}
