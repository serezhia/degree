import 'package:task_service/task_service.dart';

class Task {
  final int? id;
  final int subjectId;
  final int teacherId;
  final int? studentId;
  final int? groupId;
  final int? subgroupId;
  final String content;
  final DeadlineType deadlineType;
  final DateTime? deadline;
  final List<Tag>? tags;
  final List<TaskFile>? files;
  final bool? isDone;

  Task(
      {this.id,
      required this.subjectId,
      required this.teacherId,
      this.studentId,
      this.groupId,
      this.subgroupId,
      required this.content,
      required this.deadlineType,
      required this.deadline,
      this.tags,
      this.files,
      this.isDone});
}

enum DeadlineType {
  date,
  nextLesson,
}

// class TestTask extends Task {

//   TestTask(
//       {required super.id,
//       required super.subjectId,
//       required super.teacherId,
//       required super.content,
//       required super.deadlineType,
//       required super.deadline,
//       required super.isDone});
// }
