import '../../teachers.dart';

class MockTeacherRepository implements TeacherRepository {
  @override
  Future<List<Teacher>> getTeachersList() => Future.delayed(
        const Duration(seconds: 1),
        () {
          final teachersList = users.whereType<Teacher>().toList()
            ..sort((a, b) => a.secondName.compareTo(b.secondName));
          return teachersList;
        },
      );

  @override
  Future<Teacher> createTeacher({
    required String firstName,
    required String secondName,
    String? middleName,
    List<Subject>? subjects,
  }) =>
      Future.delayed(const Duration(seconds: 1), () {
        final teacher = Teacher(
          userId: users.length,
          teacherId: users.length,
          firstName: firstName,
          secondName: secondName,
          middleName: middleName,
          subjects: subjects,
        );
        users.add(teacher);
        return teacher;
      });

  @override
  Future<Teacher> readTeacher({
    required int teacherId,
  }) =>
      Future.delayed(
        const Duration(seconds: 1),
        () => users.firstWhere(
          (user) => user is Teacher && user.teacherId == teacherId,
        ) as Teacher,
      );

  @override
  Future<Teacher> updateTeacher({required Teacher teacher}) =>
      Future.delayed(const Duration(seconds: 1), () {
        final newTeacher = Teacher(
          teacherId: teacher.teacherId,
          firstName: teacher.firstName,
          secondName: teacher.secondName,
          middleName: teacher.middleName,
          subjects: teacher.subjects,
        );
        final oldTeacherIndex = users.indexWhere(
          (user) => user is Teacher && user.teacherId == teacher.teacherId,
        );
        users[oldTeacherIndex] = newTeacher;
        return newTeacher;
      });

  @override
  Future<void> deleteTeacher({required int teacherId}) => Future.delayed(
        const Duration(seconds: 1),
        () => users.removeWhere(
          (user) => user is Teacher && user.teacherId == teacherId,
        ),
      );
}
