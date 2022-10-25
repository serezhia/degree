import 'package:schedule_service/schedule_service.dart';

abstract class LessonRepository {
  Future<Lesson> insertLesson({
    int? groupId,
    int? subgroupId,
    required int subjectId,
    required int teacherId,
    required int cabinetId,
    required int lessonTypeId,
    required int lessonNumber,
    required DateTime day,
  });
  Future<bool> existsLesson({
    int? lessonId,
    int? groupId,
    int? subgroupId,
    int? subjectId,
    int? teacherId,
    int? cabinetId,
    int? lessonTypeId,
    int? lessonNumber,
    DateTime? day,
  });

  Future<Lesson> updateLesson(Lesson lesson);

  Future<Lesson> getLesson(int lessonId);

  Future<List<Lesson>> getAllLessons();

  Future<void> deleteLesson(int lessonId);

  Future<List<Lesson>> getLessonsByGroup(int groupId);

  Future<List<Lesson>> getLessonsBySubgroup(int subgroupId);

  Future<List<Lesson>> getLessonsByStudent(int studentId);

  Future<List<Lesson>> getLessonsByTeacher(int teacherid);

  Future<List<Lesson>> getLessonsByDay(DateTime day);

  Future<LessonType> getLessonType(int lessonTypeId);

  Future<List<LessonType>> getAllLessonTypes();

  Future<LessonType> insertLessonType(String name);

  Future<LessonType> updateLessonType(LessonType lessonType);

  Future<void> deleteLessonType(int lessonTypeId);

  Future<bool> existsLessonType({int? lessonTypeId, String? name});
}
