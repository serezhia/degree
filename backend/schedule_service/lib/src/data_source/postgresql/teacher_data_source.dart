import 'package:schedule_service/schedule_service.dart';
import 'package:schedule_service/src/models/teacher_model.dart';
import 'package:schedule_service/src/repository/teacher_repository.dart';

class PostgreTeacherDataSource extends TeacherRepository {
  final PostgreSQLConnection connection;

  PostgreTeacherDataSource(this.connection);

  @override
  Future<void> deleteTeacher(int idTeacher) async {
    await connection.query('''
    DELETE FROM teachers WHERE teacher_id = @id;
  ''', substitutionValues: {
      'id': idTeacher,
    });
  }

  @override
  Future<bool> existsTeacher(int idTeacher) {
    return connection.query('''
    SELECT * FROM teachers WHERE teacher_id = @id;
  ''', substitutionValues: {
      'id': idTeacher,
    }).then((value) => value.isNotEmpty);
  }

  @override
  Future<List<Teacher>> getAllTeachers() {
    return connection.query('''
    SELECT * FROM teachers;
  ''').then((value) => value
        .map((e) => Teacher(
              id: e[0] as int,
              userId: e[1] as int,
              firstName: e[2] as String,
              secondName: e[3] as String,
              middleName: e[4] as String,
            ))
        .toList());
  }

  @override
  Future<Teacher> getTeacher(int idTeacher) {
    return connection.query('''
    SELECT * FROM teachers WHERE teacher_id = @id;
  ''', substitutionValues: {
      'id': idTeacher,
    }).then((value) => Teacher(
          id: value.first[0] as int,
          userId: value.first[1] as int,
          firstName: value.first[2] as String,
          secondName: value.first[3] as String,
          middleName: value.first[4] as String,
        ));
  }

  @override
  Future<Teacher> updateTeacher(Teacher teacher) {
    return connection.query('''
    UPDATE teachers SET user_id = @user_id, first_name = @first_name, second_name = @second_name, middle_name = @middle_name WHERE teacher_id = @id RETURNING *;
  ''', substitutionValues: {
      'id': teacher.id,
      'user_id': teacher.userId,
      'first_name': teacher.firstName,
      'second_name': teacher.secondName,
      'middle_name': teacher.middleName,
    }).then((value) => Teacher(
          id: value.first[0] as int,
          userId: value.first[1] as int,
          firstName: value.first[2] as String,
          secondName: value.first[3] as String,
          middleName: value.first[4] as String,
        ));
  }

  @override
  Future<Teacher> insertTeacher(
      String firstName, String secondName, String middleName, int userId) {
    return connection.query('''
    INSERT INTO teachers (user_id, first_name, second_name, middle_name) VALUES (@user_id, @first_name, @second_name, @middle_name) RETURNING *;
  ''', substitutionValues: {
      'user_id': userId,
      'first_name': firstName,
      'second_name': secondName,
      'middle_name': middleName,
    }).then((value) => Teacher(
          id: value.first[0] as int,
          userId: value.first[1] as int,
          firstName: value.first[2] as String,
          secondName: value.first[3] as String,
          middleName: value.first[4] as String,
        ));
  }
}
