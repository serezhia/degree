import 'package:schedule_service/schedule_service.dart';

class Teacher {
  final int id;
  final int userId;
  final String firstName;
  final String secondName;
  final String? middleName;
  final List<Subject>? subjects;

  Teacher(
      {required this.id,
      required this.userId,
      required this.firstName,
      required this.secondName,
      required this.middleName,
      this.subjects});

  Teacher.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        firstName = json['firstName'],
        secondName = json['secondName'],
        middleName = json['middleName'],
        subjects = json['subjects'] != null
            ? (json['subjects'] as List)
                .map((e) => Subject.fromJson(e))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'firstName': firstName,
        'secondName': secondName,
        'middleName': middleName,
        'subjects': subjects?.map((e) => e.toJson()).toList(),
      };
}
