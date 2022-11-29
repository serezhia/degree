import 'package:degree_app/admin_schedule/src/model/cabinet_model.dart';

import '../../admin_schedule.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class Lesson {
  final int id;
  final Subject subject;
  final Teacher teacher;
  final LessonType lessonType;
  final int numberLesson;
  final DateTime date;
  final Cabinet cabinet;
  final Group? group;
  final Subgroup? subgroup;

  Lesson({
    required this.id,
    required this.subject,
    required this.teacher,
    required this.lessonType,
    required this.numberLesson,
    required this.date,
    required this.cabinet,
    this.group,
    this.subgroup,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
