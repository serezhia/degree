import '../../teacher_task.dart';

class Task {
  final int id;
  final Subject subject;
  final Teacher teacher;
  final String content;
  final DeadLineType deadLineType;
  final DateTime? deadLineDate;
  final Group? group;
  final Subgroup? subgroup;
  final Student? student;
  final List<FileDegree>? files;
  final List<TagTask>? tags;

  Task({
    required this.id,
    required this.subject,
    required this.teacher,
    required this.content,
    required this.deadLineType,
    this.deadLineDate,
    this.group,
    this.subgroup,
    this.student,
    this.files,
    this.tags,
  });
}

enum DeadLineType { date, lesson }
