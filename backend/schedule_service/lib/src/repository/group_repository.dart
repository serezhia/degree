import 'package:schedule_service/schedule_service.dart';

abstract class GroupRepository {
  Future<bool> existsGroup({
    String? nameGroup,
    int? idGroup,
  });

  Future<Group> insertGroup(
    int idSpeciality,
    String name,
    int course,
  );

  Future<Group> updateGroup(Group group);

  Future<Group> getGroup(int idGroup);

  Future<List<Group>> getAllGroups();

  Future<void> deleteGroup(int idGroup);

  Future<Subject> addSubjectToGroup(int idGroup, int idSubject);

  Future<bool> existsGroupsSubject(int idGroup, int idSubject);

  Future<List<Group>> getGroupsBySubject(int idSubject);

  Future<void> deleteSubjectFromGroup(int idGroup, int idSubject);

  Future<List<Subject>> getSubjectsByGroup(int idGroup);
}
