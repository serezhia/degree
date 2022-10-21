import 'package:schedule_service/schedule_service.dart';

class PostgreGroupDataSource extends GroupRepository {
  final PostgreSQLConnection connection;

  PostgreGroupDataSource(this.connection);

  @override
  Future<Subject> addSubjectToGroup(int idGroup, int idSubject) async {
    return await connection.transaction((ctx) async {
      await ctx.query('''
      INSERT INTO group_subjects (group_id, subject_id) VALUES (@group_id, @subject_id);
    ''', substitutionValues: {
        'group_id': idGroup,
        'subject_id': idSubject,
      });
      return await ctx.query('''
      SELECT * FROM subjects WHERE subject_id = @id;
    ''', substitutionValues: {
        'id': idSubject,
      }).then((value) => Subject(
            id: value.first[0] as int,
            name: value.first[1] as String,
          ));
    });
  }

  @override
  Future<void> deleteGroup(int idGroup) async {
    await connection.query('DELETE FROM groups WHERE group_id = @idGroup',
        substitutionValues: {'idGroup': idGroup});
  }

  @override
  Future<void> deleteSubjectFromGroup(int idGroup, int idSubject) async {
    await connection.query(
        'DELETE FROM group_subjects WHERE group_id = @idGroup AND subject_id = @idSubject',
        substitutionValues: {
          'idGroup': idGroup,
          'idSubject': idSubject,
        });
  }

  @override
  Future<bool> existsGroup({String? nameGroup, int? idGroup}) {
    return connection.mappedResultsQuery(
        'SELECT * FROM groups WHERE name = @nameGroup OR group_id = @idGroup',
        substitutionValues: {
          'nameGroup': nameGroup,
          'idGroup': idGroup
        }).then((value) => value.isNotEmpty);
  }

  @override
  Future<bool> existsGroupsSubject(int idGroup, int idSubject) {
    return connection.mappedResultsQuery(
        'SELECT * FROM group_subjects WHERE group_id = @idGroup AND subject_id = @idSubject',
        substitutionValues: {
          'idGroup': idGroup,
          'idSubject': idSubject
        }).then((value) => value.isNotEmpty);
  }

  @override
  Future<List<Group>> getAllGroups() async {
    final result = await connection.query('''
      SELECT * FROM groups;
    ''');
    return result
        .map((e) => Group(
              id: e[0] as int,
              idSpeciality: e[1] as int,
              name: e[2] as String,
              course: e[3] as int,
            ))
        .toList();
  }

  @override
  Future<Group> getGroup(int idGroup) async {
    return await connection.mappedResultsQuery('''
      SELECT * FROM groups WHERE group_id = @idGroup;
    ''', substitutionValues: {
      'idGroup': idGroup,
    }).then((value) {
      print(value.first['groups']!['group_id']);
      return Group(
        id: value.first['groups']!['group_id'] as int,
        idSpeciality: value.first['groups']!['speciality_id'] as int,
        name: value.first['groups']!['name'] as String,
        course: value.first['groups']!['course'] as int,
      );
    });
  }

  @override
  Future<List<Group>> getGroupsBySubject(int idSubject) {
    // TODO: implement getGroupsBySubject
    throw UnimplementedError();
  }

  @override
  Future<List<Subject>> getSubjectsByGroup(int idGroup) {
    return connection.mappedResultsQuery('''
      SELECT * FROM subjects WHERE subject_id IN (SELECT subject_id FROM group_subjects WHERE group_id = @idGroup);
    ''', substitutionValues: {
      'idGroup': idGroup,
    }).then((value) {
      return value
          .map((e) => Subject(
                id: e['subjects']!['subject_id'] as int,
                name: e['subjects']!['name'] as String,
              ))
          .toList();
    });
  }

  @override
  Future<Group> insertGroup(int idSpeciality, String name, int course) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
      INSERT INTO groups (speciality_id, name, course) VALUES (@speciality_id, @name, @course) RETURNING group_id;
    ''', substitutionValues: {
        'speciality_id': idSpeciality,
        'name': name,
        'course': course,
      });
      return await ctx.query('''
      SELECT * FROM groups WHERE group_id = @id;
    ''', substitutionValues: {
        'id': result.first[0] as int,
      }).then((value) => Group(
            id: value.first[0] as int,
            idSpeciality: value.first[1] as int,
            name: value.first[2] as String,
            course: value.first[3] as int,
          ));
    });
  }

  @override
  Future<Group> updateGroup(Group group) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
      UPDATE groups SET idSpetiality = @spetiality_id, name = @name, course = @course WHERE group_id = @id RETURNING speciality_id, name, course;
    ''', substitutionValues: {
        'id': group.id,
        'speciality_id': group.idSpeciality,
        'name': group.name,
        'course': group.course,
      });
      return Group(
        id: group.id,
        idSpeciality: result.first[0] as int,
        name: result.first[1] as String,
        course: result.first[2] as int,
      );
    });
  }
}
