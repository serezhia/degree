import '../../admin_schedule.dart';

abstract class LessonTypeRepository {
  Future<List<LessonType>> getLessonTypes();

  Future<LessonType> getLessonType(String name);

  Future<LessonType> addLessonType(String name);

  Future<LessonType> updateLessonType(LessonType lessonType);

  Future<void> deleteLessonType(String name);
}
