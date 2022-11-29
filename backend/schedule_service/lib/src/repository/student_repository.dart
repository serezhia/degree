import 'package:schedule_service/schedule_service.dart';

abstract class StudentRepository {
  Future<bool> existsStudent(
      {int? idStudent,
      String? firstName,
      String? secondName,
      String? middleName,
      int? idGroup});

  Future<Student> insertStudent(int userId, String firstName, String secondName,
      String? middleName, int groupId, int subgroupId);

  Future<Student> updateStudent(Student student);

  Future<Student> getStudent(int idStudent);

  Future<List<Student>> getAllStudents();

  Future<void> deleteStudent(int idStudent);

  Future<List<Student>> getAllStudentsByGroup(int idGroup);

  Future<List<Student>> getAllStudentsBySubgroup(int idSubgroup);

  Future<Student> getStudentByUserId(int userId);
}
