import 'package:degree_app/teacher/src/data/mock_data.dart';

import '../../teacher.dart';

class MockMainTeacherRepository implements MainTeacherRepository {
  @override
  Future<Group> getGroup(int id) => Future.delayed(
        const Duration(seconds: 2),
        () => mockGroupList.firstWhere((element) => element.id == id),
      );

  @override
  Future<List<Group>> getGroups() => Future.delayed(
        const Duration(seconds: 2),
        () => mockGroupList,
      );

  @override
  Future<Lesson> getLesson(int id) => Future.delayed(
        const Duration(seconds: 2),
        () => mockLessonList.firstWhere((element) => element.id == id),
      );

  @override
  Future<List<Lesson>> getLessonsByTeacherOnWeek(
    int teacherId,
    DateTimeRange week,
  ) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => mockLessonList
            .where(
              (element) =>
                  element.teacher.teacherId == teacherId &&
                  element.date
                      .isAfter(week.start.subtract(const Duration(days: 1))) &&
                  element.date.isBefore(week.end),
            )
            .toList(),
      );

  @override
  Future<List<Student>> getStudentsList() => Future.delayed(
        const Duration(seconds: 2),
        () => mockUserList.whereType<Student>().toList(),
      );

  @override
  Future<Subject> getSubject(int id) => Future.delayed(
        const Duration(seconds: 2),
        () => mockSubjectList.firstWhere((element) => element.id == id),
      );

  @override
  Future<List<Subject>> getSubjectsList() => Future.delayed(
        const Duration(seconds: 2),
        () => mockSubjectList,
      );

  @override
  Future<Student> readStudent({required int studentId}) => Future.delayed(
        const Duration(seconds: 2),
        () => mockUserList
            .whereType<Student>()
            .firstWhere((element) => element.userId == studentId),
      );

  @override
  Future<Teacher> readTeacher({required int teacherId}) => Future.delayed(
        const Duration(seconds: 2),
        () => mockUserList
            .whereType<Teacher>()
            .firstWhere((element) => element.teacherId == teacherId),
      );

  @override
  Future<List<Lesson>> getLessonsByTeacherOnDay(
    int teacherId,
    DateTime date,
  ) =>
      Future.delayed(const Duration(seconds: 2), () {
        final lessons = <Lesson>[];
        for (final lesson in mockLessonList) {
          if (lesson.teacher.teacherId == teacherId &&
              lesson.date.day == date.day &&
              lesson.date.month == date.month &&
              lesson.date.year == date.year) {
            lessons.add(lesson);
          }
        }
        lessons.sort((a, b) => a.numberLesson.compareTo(b.numberLesson));
        return lessons;
      });
}
