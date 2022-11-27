import 'package:degree_app/admin_groups/src/repository/speciality_repository.dart';
import 'package:degree_app/admin_groups/src/repository/subgroup_repository.dart';

import '../../../admin_groups.dart';

part 'group_panel_state.dart';

class GroupPanelCubit extends Cubit<GroupPanelState> {
  GroupPanelCubit(
    this.groupRepository,
    this.specialityRepository,
    this.subgroupRepository,
  ) : super(EmptyGroupPanelState());

  final GroupRepository groupRepository;

  final SpecialityRepository specialityRepository;

  final SubgroupRepository subgroupRepository;

  Future<void> openAddPanel() async {
    emit(AddGroupPanelState());
  }

  Future<void> openEditPanel(Group group) async {
    emit(EditGroupPanelState(group: group));
  }

  Future<List<Speciality>> getSpecialitiesForField() =>
      specialityRepository.getSpecialitiesList();

  Future<Speciality> createSpecialityForField(String name) =>
      specialityRepository.createSpeciality(name);

  Future<void> deleteSpecialityForField(int id) =>
      specialityRepository.deleteSpeciality(id);

  Future<List<Subgroup>> createSubgroups(String groupName, int count) async {
    final subgroups = <Subgroup>[
      ...await subgroupRepository.createSubgroups(groupName, count)
    ];

    return subgroups;
  }

  Future<void> addGroup({
    required String name,
    required Speciality speciality,
    required int course,
    required List<Subgroup> subgroups,
  }) async {
    emit(LoadingGroupPanelState());
    try {
      emit(
        InfoGroupPanelState(
          group: await groupRepository.createGroup(
            name,
            speciality,
            course,
            subgroups,
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
