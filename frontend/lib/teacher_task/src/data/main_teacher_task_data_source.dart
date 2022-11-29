import 'package:degree_app/teacher_task/teacher_task.dart';

class MainTaskDataSource implements TaskRepository {
  @override
  Future<Task> addTask(
      {required Subject subject,
      required Teacher teacher,
      required String content,
      required DeadLineType deadLineType,
      required DateTime? deadLineDate,
      List<TagTask>? tags,
      List<FileDegree>? files,
      Group? group,
      Subgroup? subgroup,
      Student? student}) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasksByDay(DateTime date) {
    // TODO: implement getTasksByDay
    throw UnimplementedError();
  }

  @override
  Future<Task> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
