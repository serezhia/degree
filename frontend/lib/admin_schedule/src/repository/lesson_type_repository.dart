import '../../admin_schedule.dart';

abstract class LessonTypeRepository {
  Future<List<LessonType>> getLessonTypes();

  Future<LessonType> getLessonType(int id);

  Future<LessonType> addLessonType(String name);

  Future<void> deleteLessonType(int id);
}
