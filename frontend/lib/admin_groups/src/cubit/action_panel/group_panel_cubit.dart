import '../../../admin_groups.dart';

part 'group_panel_state.dart';

class GroupPanelCubit extends Cubit<GroupPanelState> {
  GroupPanelCubit(this.groupRepository) : super(EmptyGroupPanelState());

  final GroupRepository groupRepository;

  Future<void> openAddPanel() async {
    emit(AddGroupPanelState());
  }

  Future<void> openEditPanel(Group group) async {
    emit(EditGroupPanelState(group: group));
  }

  Future<void> addGroup({
    required String name,
    required String specialityName,
    required int course,
    required int subgroupsCount,
  }) async {
    emit(LoadingGroupPanelState());
    try {
      emit(
        InfoGroupPanelState(
          group: await groupRepository.createGroup(
            name,
            specialityName,
            course,
            subgroupsCount,
          ),
        ),
      );
    } catch (e) {
      emit(ErrorGroupPanelState(message: e.toString()));
    }
  }

  Future<void> getGroup(int id) async {
    emit(LoadingGroupPanelState());
    try {
      emit(
        InfoGroupPanelState(
          group: await groupRepository.getGroup(id),
        ),
      );
    } catch (e) {
      emit(ErrorGroupPanelState(message: e.toString()));
    }
  }

  Future<void> editGroup(Group group) async {
    emit(LoadingGroupPanelState());
    try {
      emit(
        InfoGroupPanelState(
          group: await groupRepository.editGroup(group),
        ),
      );
    } catch (e) {
      emit(ErrorGroupPanelState(message: e.toString()));
    }
  }

  Future<void> deleteGroup(int id) async {
    emit(LoadingGroupPanelState());
    try {
      await groupRepository.deleteGroup(id);
      emit(EmptyGroupPanelState());
    } catch (e) {
      emit(ErrorGroupPanelState(message: e.toString()));
    }
  }
}
