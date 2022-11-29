import 'package:degree_app/admin_schedule/src/model/cabinet_model.dart';

import '../../admin_schedule.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getLessonsByDay(DateTime date);

  Future<Lesson> getLesson(int id);

  Future<Lesson> addLesson({
    required Subject subject,
    required Teacher teacher,
    required LessonType lessonType,
    required int numberLesson,
    required DateTime date,
    required Cabinet cabinet,
    Group? group,
    Subgroup? subgroup,
  });

  Future<Lesson> updateLesson(Lesson lesson);

  Future<void> deleteLesson(int id);
}
