import 'dart:developer';

import '../../admin_schedule.dart';

class MockLessonRepository implements LessonRepository {
  @override
  Future<Lesson> addLesson({
    required int subjectId,
    required int teacherId,
    required LessonType lessonType,
    required int numberLesson,
    required DateTime date,
    required int cabinetNumber,
    int? groupId,
    int? subgroupId,
    int? studentId,
  }) {
    final lesson = Lesson(
      id: lessons.length,
      subject: subjects.firstWhere((element) => element.id == subjectId),
      teacher: users.firstWhere(
        (element) => element is Teacher && element.teacherId == teacherId,
      ) as Teacher,
      lessonType: lessonType,
      numberLesson: numberLesson,
      date: date,
      cabinet: cabinetNumber,
      student: studentId != null
          ? users.firstWhere(
              (element) => element is Student && element.studentId == studentId,
            ) as Student
          : null,
      group: groupId != null
          ? groups.firstWhere((element) => element.id == groupId)
          : null,
      subgroup: subgroupId != null
          ? subgroups.firstWhere((element) => element.id == subgroupId)
          : null,
    );
    lessons.add(lesson);
    return Future.delayed(const Duration(seconds: 2), () => lesson);
  }

  @override
  Future<void> deleteLesson(int id) {
    lessons.removeWhere((element) => element.id == id);
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<Lesson> getLesson(int id) => Future.delayed(
        const Duration(seconds: 2),
        () => lessons.firstWhere((element) => element.id == id),
      );

  @override
  Future<List<Lesson>> getLessons() =>
      Future.delayed(const Duration(seconds: 2), () => lessons);

  @override
  Future<List<Lesson>> getLessonsByDay(DateTime date) {
    log(
      lessons
          .where(
            (element) =>
                element.date.day == date.day &&
                element.date.month == date.month &&
                element.date.year == date.year,
          )
          .toList()
          .length
          .toString(),
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => lessons.where((element) => element.date.day == date.day).toList(),
    );
  }

  @override
  Future<List<Lesson>> getLessonsByGroup(int groupId) {
    final group = groups.firstWhere((element) => element.id == groupId);
    return Future.delayed(
      const Duration(seconds: 2),
      () => lessons.where((element) => element.group == group).toList(),
    );
  }

  @override
  Future<List<Lesson>> getLessonsByStudent(int studentId) {
    final student = users.firstWhere(
      (element) => element is Student && element.studentId == studentId,
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => lessons.where((element) => element.student == student).toList(),
    );
  }

  @override
  Future<List<Lesson>> getLessonsBySubgroup(int subgroupId) {
    final subgroup = subgroups.firstWhere(
      (element) => element.id == subgroupId,
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => lessons.where((element) => element.subgroup == subgroup).toList(),
    );
  }

  @override
  Future<List<Lesson>> getLessonsByTeacher(int teacherId) {
    final teacher = users.firstWhere(
      (element) => element is Teacher && element.teacherId == teacherId,
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => lessons.where((element) => element.teacher == teacher).toList(),
    );
  }

  @override
  Future<Lesson> updateLesson(Lesson lesson) {
    final index = lessons.indexWhere((element) => element.id == lesson.id);
    lessons[index] = lesson;
    return Future.delayed(const Duration(seconds: 2), () => lesson);
  }

  @override
  Future<List<Lesson>> getLessonsByCabinet(int numberRoom) => Future.delayed(
        const Duration(seconds: 2),
        () =>
            lessons.where((element) => element.cabinet == numberRoom).toList(),
      );
}
