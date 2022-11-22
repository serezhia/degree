import '../../teacher.dart';

part 'subject_model.g.dart';

@JsonSerializable()
class Subject {
  final int id;
  final String name;

  Subject({
    required this.id,
    required this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}
