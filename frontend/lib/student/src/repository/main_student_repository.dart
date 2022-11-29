import '../../student.dart';

abstract class MainStudentRepository {
  Future<List<Subject>> getSubjectsList();

  Future<Subject> getSubject(int id);

  Future<List<Group>> getGroups();

  Future<Group> getGroup(int id);

  Future<List<Subgroup>> getSubgroups();

  Future<Subgroup> getSubgroup(int id);

  Future<Teacher> readTeacher({
    required int teacherId,
  });

  Future<Student> readStudent({
    required int studentId,
  });

  Future<List<Student>> getStudentsList();

  Future<List<Lesson>> getLessonsByTeacherOnWeek(
    DateTimeRange week,
  );

  Future<Lesson> getLesson(int id);
}
