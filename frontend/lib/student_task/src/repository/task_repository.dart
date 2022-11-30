import '../../student_task.dart';

abstract class TaskRepository {
  Future<List<Task>> getCompletedTasks();

  Future<List<Task>> getUncompletedTasks();

  Future<Task> getTask(int id);

  Future<void> completeTask(int id);
}
