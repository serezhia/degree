import '../../teacher_task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasksByDay(DateTime date);

  Future<Task> getTask(int id);

  Future<Task> addTask({
    required Subject subject,
    required Teacher teacher,
    required String content,
    required String date,
    required String time,
    required DeadLineType deadLineType,
    required DateTime? deadLineDate,
    List<TagTask>? tags,
    List<FileDegree>? files,
    Group? group,
    Subgroup? subgroup,
    Student? student,
  });

  Future<Task> updateTask(Task task);

  Future<void> deleteTask(int id);
}
