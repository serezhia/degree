import 'package:degree_app/admin/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';

@JsonSerializable()
class Student extends User {
  final int studentId;
  final int groupId;
  final int subgroupId;

  Student({
    required super.firstName,
    required super.secondName,
    required this.studentId,
    required this.groupId,
    required this.subgroupId,
    super.userId,
    super.middleName,
    super.registrationCode,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
}
