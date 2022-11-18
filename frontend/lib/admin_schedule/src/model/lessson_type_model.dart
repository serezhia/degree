import '../../admin_schedule.dart';

part 'lessson_type_model.g.dart';

@JsonSerializable()
class LessonType {
  final int id;
  final String name;

  LessonType({
    required this.id,
    required this.name,
  });

  factory LessonType.fromJson(Map<String, dynamic> json) =>
      _$LessonTypeFromJson(json);
}
