import '../../admin_groups.dart';

abstract class GroupRepository {
  Future<List<Group>> getGroups();

  Future<Group> getGroup(int id);

  Future<Group> createGroup(
    String name,
    String specialityName,
    int course,
    int subgroupsCount,
  );

  Future<Group> editGroup(Group group);

  Future<void> deleteGroup(int id);
}
