import 'package:schedule_service/schedule_service.dart';

class PostgreStudentDataSource extends StudentRepository {
  final PostgreSQLConnection connection;

  PostgreStudentDataSource(this.connection);
  @override
  Future<void> deleteStudent(int idStudent) {
    return connection.mappedResultsQuery(
      'DELETE FROM students WHERE student_id = @id',
      substitutionValues: {'id': idStudent},
    );
  }

  @override
  Future<bool> existsStudent(
      {int? idStudent,
      String? firstName,
      String? secondName,
      String? middleName,
      int? idGroup}) {
    if (idStudent != null) {
      return connection.mappedResultsQuery(
        'SELECT * FROM students WHERE student_id = @id',
        substitutionValues: {
          'id': idStudent,
        },
      ).then((value) {
        return value.isNotEmpty;
      });
    } else if (firstName != null &&
        secondName != null &&
        middleName != null &&
        idGroup != null) {
      return connection.mappedResultsQuery(
        'SELECT * FROM students WHERE first_name = @firstName AND second_name = @secondName AND middle_name = @middleName AND group_id = @idGroup',
        substitutionValues: {
          'firstName': firstName,
          'secondName': secondName,
          'middleName': middleName,
          'idGroup': idGroup,
        },
      ).then((value) {
        return value.isNotEmpty;
      });
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<List<Student>> getAllStudents() {
    return connection
        .mappedResultsQuery(
          'SELECT * FROM students',
        )
        .then((value) => value.map((e) {
              return Student(
                id: e['students']!['student_id'] as int,
                userId: e['students']!['user_id'] as int,
                firstName: e['students']!['first_name'] as String,
                secondName: e['students']!['second_name'] as String,
                middleName: e['students']!['middle_name'] as String?,
                groupId: e['students']!['group_id'] as int,
                subgroupId: e['students']!['subgroup_id'] as int,
              );
            }).toList());
  }

  @override
  Future<Student> getStudent(int idStudent) async {
    return await connection.mappedResultsQuery(
      'SELECT * FROM students WHERE student_id = @id',
      substitutionValues: {
        'id': idStudent,
      },
    ).then((value) {
      return Student(
        userId: value.first['students']!['user_id'] as int,
        id: value.first['students']!['student_id'] as int,
        firstName: value.first['students']!['first_name'] as String,
        secondName: value.first['students']!['second_name'] as String,
        middleName: value.first['students']!['middle_name'] as String?,
        groupId: value.first['students']!['group_id'] as int,
        subgroupId: value.first['students']!['subgroup_id'] as int,
      );
    });
  }

  @override
  Future<Student> insertStudent(int userId, String firstName, String secondName,
      String? middleName, int groupId, int subgroupId) {
    return connection.mappedResultsQuery(
      'INSERT INTO students (user_id, first_name, second_name, middle_name, group_id, subgroup_id) VALUES (@userId, @firstName, @secondName, @middleName, @groupId, @subgroupId) RETURNING *',
      substitutionValues: {
        'userId': userId,
        'firstName': firstName,
        'secondName': secondName,
        'middleName': middleName,
        'groupId': groupId,
        'subgroupId': subgroupId,
      },
    ).then((value) {
      return Student(
        userId: value.first['students']!['user_id'] as int,
        id: value.first['students']!['student_id'] as int,
        firstName: value.first['students']!['first_name'] as String,
        secondName: value.first['students']!['second_name'] as String,
        middleName: value.first['students']!['middle_name'] as String?,
        groupId: value.first['students']!['group_id'] as int,
        subgroupId: value.first['students']!['subgroup_id'] as int,
      );
    });
  }

  @override
  Future<Student> updateStudent(Student student) {
    return connection.mappedResultsQuery(
      'UPDATE students SET user_id = @userId, first_name = @firstName, second_name = @secondName, middle_name = @middleName, group_id = @groupId, subgroup_id = @subgroupId WHERE student_id = @id RETURNING *',
      substitutionValues: {
        'userId': student.userId,
        'firstName': student.firstName,
        'secondName': student.secondName,
        'middleName': student.middleName,
        'groupId': student.groupId,
        'subgroupId': student.subgroupId,
        'id': student.id,
      },
    ).then((value) {
      return Student(
        userId: value.first['students']!['user_id'] as int,
        id: value.first['students']!['student_id'] as int,
        firstName: value.first['students']!['first_name'] as String,
        secondName: value.first['students']!['second_name'] as String,
        middleName: value.first['students']!['middle_name'] as String?,
        groupId: value.first['students']!['group_id'] as int,
        subgroupId: value.first['students']!['subgroup_id'] as int,
      );
    });
  }

  @override
  Future<List<Student>> getAllStudentsByGroup(int idGroup) {
    return connection.mappedResultsQuery(
      'SELECT * FROM students WHERE group_id = @id',
      substitutionValues: {
        'id': idGroup,
      },
    ).then((value) => value.map((e) {
          return Student(
            id: e['students']!['student_id'] as int,
            userId: e['students']!['user_id'] as int,
            firstName: e['students']!['first_name'] as String,
            secondName: e['students']!['second_name'] as String,
            middleName: e['students']!['middle_name'] as String?,
            groupId: e['students']!['group_id'] as int,
            subgroupId: e['students']!['subgroup_id'] as int,
          );
        }).toList());
  }

  @override
  Future<List<Student>> getAllStudentsBySubgroup(int idSubgroup) {
    return connection.mappedResultsQuery(
      'SELECT * FROM students WHERE subgroup_id = @id',
      substitutionValues: {
        'id': idSubgroup,
      },
    ).then((value) => value.map((e) {
          return Student(
            id: e['students']!['student_id'] as int,
            userId: e['students']!['user_id'] as int,
            firstName: e['students']!['first_name'] as String,
            secondName: e['students']!['second_name'] as String,
            middleName: e['students']!['middle_name'] as String?,
            groupId: e['students']!['group_id'] as int,
            subgroupId: e['students']!['subgroup_id'] as int,
          );
        }).toList());
  }

  @override
  Future<Student> getStudentByUserId(int userId) async {
    return await connection.query('''
    SELECT * FROM students WHERE user_id = @id;
  ''', substitutionValues: {
      'id': userId,
    }).then((value) => Student(
          id: value.first[0] as int,
          userId: value.first[1] as int,
          firstName: value.first[2] as String,
          secondName: value.first[3] as String,
          middleName: value.first[4] as String?,
          groupId: value.first[5] as int,
          subgroupId: value.first[6] as int,
        ));
  }
}
