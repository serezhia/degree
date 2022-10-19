import 'package:schedule_service/schedule_service.dart';

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
  Future<List<Teacher>> getAllTeachers() async {
    return await connection.query('''
    SELECT * FROM teachers;
  ''').then((value) => value
        .map((e) => Teacher(
              id: e[0] as int,
              userId: e[1] as int,
              firstName: e[2] as String,
              secondName: e[3] as String,
              middleName: e[4] as String?,
            ))
        .toList());
  }

  @override
  Future<Teacher> getTeacher(int idTeacher) async {
    return await connection.query('''
    SELECT * FROM teachers WHERE teacher_id = @id;
  ''', substitutionValues: {
      'id': idTeacher,
    }).then((value) => Teacher(
          id: value.first[0] as int,
          userId: value.first[1] as int,
          firstName: value.first[2] as String,
          secondName: value.first[3] as String,
          middleName: value.first[4] as String?,
        ));
  }

  @override
  Future<Teacher> updateTeacher(Teacher teacher) async {
    return await connection.query('''
    UPDATE teachers SET user_id = @user_id, firstname = @first_name, secondname = @second_name, middlename = @middle_name WHERE teacher_id = @id RETURNING *;
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
          middleName: value.first[4] as String?,
        ));
  }

  @override
  Future<Teacher> insertTeacher(String firstName, String secondName,
      String? middleName, int userId) async {
    return await connection.query('''
    INSERT INTO teachers (firstname, secondname, middlename) VALUES ( @first_name, @second_name, @middle_name) RETURNING *;
  ''', substitutionValues: {
      'first_name': firstName,
      'second_name': secondName,
      'middle_name': middleName,
    }).then((value) => Teacher(
          id: value.first[0] as int,
          userId: value.first[1] as int,
          firstName: value.first[2] as String,
          secondName: value.first[3] as String,
          middleName: value.first[4] as String?,
        ));
  }

  @override
  Future<List<Teacher>> getTeachersBySubject(int idSubject) async {
    return await connection.query('''
    SELECT * FROM teachers WHERE teacher_id IN (SELECT teacher_id FROM teacher_subjects WHERE subject_id = @id);
  ''', substitutionValues: {
      'id': idSubject,
    }).then((value) => value
        .map((e) => Teacher(
              id: e[0] as int,
              userId: e[1] as int,
              firstName: e[2] as String,
              secondName: e[3] as String,
              middleName: e[4] as String?,
            ))
        .toList());
  }

  @override
  Future<bool> existsTeacher(
      {int? idTeacher,
      String? firstName,
      String? secondName,
      String? middleName}) async {
    if (idTeacher != null) {
      return await connection.query('''
      SELECT EXISTS(SELECT 1 FROM teachers WHERE teacher_id = @id);
    ''', substitutionValues: {
        'id': idTeacher,
      }).then((value) => value.first[0] as bool);
    } else if (firstName != null && secondName != null && middleName != null) {
      return await connection.query('''
      SELECT EXISTS(SELECT 1 FROM teachers WHERE firstname = @first_name AND secondname = @second_name AND middlename = @middle_name);
    ''', substitutionValues: {
        'first_name': firstName,
        'second_name': secondName,
        'middle_name': middleName,
      }).then((value) => value.first[0] as bool);
    } else if (firstName != null && secondName != null) {
      return await connection.query('''
      SELECT EXISTS(SELECT 1 FROM teachers WHERE firstname = @first_name AND secondname = @second_name);
    ''', substitutionValues: {
        'first_name': firstName,
        'second_name': secondName,
      }).then((value) => value.first[0] as bool);
    } else {
      return false;
    }
  }

  @override
  Future<Subject> addSubjectToTeacher(int idTeacher, int idSubject) async {
    return await connection.transaction((ctx) async {
      await ctx.query('''
      INSERT INTO teacher_subjects (teacher_id, subject_id) VALUES (@teacher_id, @subject_id);
    ''', substitutionValues: {
        'teacher_id': idTeacher,
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
  Future<bool> existsTeachersSubject(int idTeacher, int idSubject) async {
    return connection.query('''
    SELECT EXISTS(SELECT 1 FROM teacher_subjects WHERE teacher_id = @teacher_id AND subject_id = @subject_id);
  ''', substitutionValues: {
      'teacher_id': idTeacher,
      'subject_id': idSubject,
    }).then((value) => value.first[0] as bool);
  }

  @override
  Future<void> deleteSubjectFromTeacher(int idTeacher, int idSubject) async {
    await connection.query('''
      DELETE FROM teacher_subjects WHERE teacher_id = @teacher_id AND subject_id = @subject_id;
    ''', substitutionValues: {
      'teacher_id': idTeacher,
      'subject_id': idSubject,
    });
  }

  @override
  Future<List<Subject>> getSubjectsByTeacher(int idTeacher) {
    return connection.query('''
      SELECT * FROM subjects WHERE subject_id IN (SELECT subject_id FROM teacher_subjects WHERE teacher_id = @id);
    ''', substitutionValues: {
      'id': idTeacher,
    }).then((value) => value
        .map((e) => Subject(
              id: e[0] as int,
              name: e[1] as String,
            ))
        .toList());
  }
}
