import '../../../admin_groups.dart';

part 'groups_page_state.dart';

class GroupsPageCubit extends Cubit<GroupsPageState> {
  GroupsPageCubit(this.groupRepository) : super(InitialGroupsPageState());

  final GroupRepository groupRepository;

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
