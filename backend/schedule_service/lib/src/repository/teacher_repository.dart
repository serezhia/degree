import 'package:schedule_service/schedule_service.dart';

abstract class TeacherRepository {
  Future<bool> existsTeacher(
      {int? idTeacher,
      String? firstName,
      String? secondName,
      String? middleName});

  Future<Teacher> insertTeacher(
      String firstName, String secondName, String? middleName, int userId);

  Future<Teacher> updateTeacher(Teacher teacher);

  Future<Teacher> getTeacher(int idTeacher);

  Future<List<Teacher>> getAllTeachers();

  Future<Teacher> getTeacherByUserId(int userId);

  Future<void> deleteTeacher(int idTeacher);

  Future<List<Teacher>> getTeachersBySubject(int idSubject);

  Future<Subject> addSubjectToTeacher(int idTeacher, int idSubject);

  Future<void> deleteSubjectFromTeacher(int idTeacher, int idSubject);

  Future<bool> existsTeachersSubject(int idTeacher, int idSubject);

  Future<List<Subject>> getSubjectsByTeacher(int idTeacher);
}
