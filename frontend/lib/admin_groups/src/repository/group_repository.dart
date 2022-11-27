import '../../admin_groups.dart';

abstract class GroupRepository {
  Future<List<Group>> getGroups();

  Future<Group> getGroup(int id);

  Future<Group> createGroup(
    String name,
    Speciality speciality,
    int course,
    List<Subgroup> subgroups,
  );

  Future<void> deleteGroup(int id);
}
