import '../../admin_students.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudentsList();

  Future<Student> createStudent({
    required String firstName,
    required String secondName,
    required int groupId,
    required int subgroupId,
    String? middleName,
  });

  Future<Student> readStudent({
    required int studentId,
  });

  Future<Student> updateStudent({
    required int studentId,
    required int userId,
    required String firstName,
    required String secondName,
    required String groupName,
    required String subgroupName,
    String? middleName,
  });

  Future<void> deleteStudent({required int studentId});
}
