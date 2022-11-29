import '../../student.dart';

part 'student_model.g.dart';

@JsonSerializable()
class Student extends User {
  final int studentId;

  final Group group;

  final Subgroup subgroup;

  String get fullName => '$secondName $firstName ${middleName ?? ''}';
  Student({
    required this.studentId,
    required super.firstName,
    required super.secondName,
    required this.group,
    required this.subgroup,
    super.userId,
    super.middleName,
    super.registrationCode,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
