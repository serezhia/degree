import '../../admin_teachers.dart';

part 'teacher_model.g.dart';

@JsonSerializable()
class Teacher extends User {
  final int teacherId;

  final List<Subject>? subjects;

  String get fullName => '$secondName $firstName $middleName';

  Teacher({
    required super.firstName,
    required super.secondName,
    required this.teacherId,
    super.userId,
    super.middleName,
    super.registrationCode,
    this.subjects,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
}
