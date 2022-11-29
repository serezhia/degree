import 'package:degree_app/admin_groups/admin_groups.dart';

import '../../admin_students.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudentsList();

  Future<Student> createStudent({
    required String firstName,
    required String secondName,
    required Group group,
    required Subgroup subgroup,
    String? middleName,
  });

  Future<Student> readStudent({
    required int studentId,
  });

  Future<Student> updateStudent(Student student);

  Future<void> deleteStudent({required int studentId});
}
