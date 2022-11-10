import '../../teachers.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getTeachersList();

  Future<Teacher> createTeacher({
    required String firstName,
    required String secondName,
    String? middleName,
    List<Subject>? subjects,
  });

  Future<Teacher> readTeacher({
    required int teacherId,
  });

  Future<Teacher> updateTeacher({required Teacher teacher});

  Future<void> deleteTeacher({required int teacherId});
}
