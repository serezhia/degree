import '../../admin_schedule.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getLessons();

  Future<List<Lesson>> getLessonsByDay(DateTime date);

  Future<List<Lesson>> getLessonsByTeacher(int teacherId);

  Future<List<Lesson>> getLessonsByGroup(int groupId);

  Future<List<Lesson>> getLessonsBySubgroup(int subgroupId);

  Future<List<Lesson>> getLessonsByCabinet(int numberRoom);

  Future<List<Lesson>> getLessonsByStudent(int studentId);

  Future<Lesson> getLesson(int id);

  Future<Lesson> addLesson({
    required String nameSubject,
    required Teacher teacher,
    required LessonType lessonType,
    required int numberLesson,
    required DateTime date,
    required int cabinetNumber,
    Group? group,
    Subgroup? subgroup,
    Student? student,
  });

  Future<Lesson> updateLesson(Lesson lesson);

  Future<void> deleteLesson(int id);
}
