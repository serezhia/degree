import 'package:degree_app/admin_groups/admin_groups.dart';

import '../../admin_students.dart';

part 'student_model.g.dart';

@JsonSerializable()
class Student extends User {
  final int studentId;

  final Group group;

  final Subgroup subgroup;

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
