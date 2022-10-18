import 'package:schedule_service/src/models/teacher_model.dart';

abstract class TeacherRepository {
  Future<bool> existsTeacher(int idTeacher);

  Future<Teacher> insertTeacher(
      String firstName, String secondName, String middleName, int userId);

  Future<Teacher> updateTeacher(Teacher teacher);

  Future<Teacher> getTeacher(int idTeacher);

  Future<List<Teacher>> getAllTeachers();

  Future<void> deleteTeacher(int idTeacher);
}
