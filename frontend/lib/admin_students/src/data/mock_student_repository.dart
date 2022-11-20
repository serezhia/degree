import 'package:degree_app/admin_groups/admin_groups.dart';

import '../../admin_students.dart';

class MockStudentRepository implements StudentRepository {
  @override
  Future<List<Student>> getStudentsList() => Future.delayed(
        const Duration(seconds: 1),
        () {
          final studentsList = users.whereType<Student>().toList()
            ..sort((a, b) => a.secondName.compareTo(b.secondName));
          return studentsList;
        },
      );

  @override
  Future<Student> createStudent({
    required String firstName,
    required String secondName,
    required int groupId,
    required int subgroupId,
    String? middleName,
  }) =>
      Future.delayed(const Duration(seconds: 1), () {
        final group = groups.firstWhere((group) => group.id == groupId);

        final subgroup =
            subgroups.firstWhere((subgroup) => subgroup.id == subgroupId);

        final students = users.whereType<Student>().toList();
        final student = Student(
          userId: users.length,
          studentId: students.length,
          firstName: firstName,
          secondName: secondName,
          middleName: middleName,
          group: group,
          subgroup: subgroup,
        );

        users.add(student);
        return student;
      });

  @override
  Future<Student> readStudent({
    required int studentId,
  }) =>
      Future.delayed(
        const Duration(seconds: 1),
        () => users.firstWhere(
          (user) => user is Student && user.studentId == studentId,
        ) as Student,
      );

  @override
  Future<Student> updateStudent({
    required int studentId,
    required int userId,
    required String firstName,
    required String secondName,
    required String groupName,
    required String subgroupName,
    String? middleName,
  }) =>
      Future.delayed(const Duration(seconds: 1), () {
        final group = groups.firstWhere((group) => group.name == groupName);
        final subgroup =
            subgroups.firstWhere((subgroup) => subgroup.name == subgroupName);
        final newStudent = Student(
          userId: userId,
          studentId: studentId,
          firstName: firstName,
          secondName: secondName,
          middleName: middleName,
          group: group,
          subgroup: subgroup,
        );
        final oldStudentIndex = users.indexWhere(
          (user) => user is Student && user.studentId == studentId,
        );
        users[oldStudentIndex] = newStudent;
        return newStudent;
      });

  @override
  Future<void> deleteStudent({required int studentId}) => Future.delayed(
        const Duration(seconds: 1),
        () => users.removeWhere(
          (user) => user is Student && user.studentId == studentId,
        ),
      );
}
