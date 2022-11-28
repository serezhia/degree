import 'package:degree_app/admin_groups/src/repository/subgroup_repository.dart';

import '../../../admin_groups.dart';

part 'groups_page_state.dart';

class GroupsPageCubit extends Cubit<GroupsPageState> {
  GroupsPageCubit(this.groupRepository, this.subgroupRepository)
      : super(InitialGroupsPageState());

  final GroupRepository groupRepository;
  final SubgroupRepository subgroupRepository;

  Future<List<Group>> getGroupsForField() async => groupRepository.getGroups();

  Future<List<Subgroup>> getSubgroupsForField() async =>
      subgroupRepository.getSubgroups();

  Future<void> getGroups() async {
    emit(LoadingGroupsPageState());
    try {
      emit(
        LoadedGroupsPageState(
          groups: await groupRepository.getGroups(),
        ),
      );
    } catch (e) {
      emit(ErrorGroupsPageState(message: e.toString()));
    }
  }
}
