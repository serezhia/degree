import 'package:task_service/task_service.dart';

abstract class TaskRepository {
  Future<bool> existsTask(int id);

  Future<List<Task>> getTasks();

  Future<Task> getTask(int id);

  Future<Task> createTask(Task task);

  Future<Task> updateTask(Task task);

  Future<void> deleteTask(int id);

  Future<List<Task>> getTasksByTeacherId(int teacherId);

  Future<List<Task>> getTasksByStudent(
      int studentId, int groupId, int subgroupId);

  Future<void> addTag(int taskId, int tagId);

  Future<bool> isTagExist(int taskId, int tagId);

  Future<void> deleteTag(int taskId, int tagId);

  Future<void> addFile(int taskId, int fileId);

  Future<bool> isFileExist(int taskId, int fileId);

  Future<void> deleteFile(int taskId, int fileId);

  Future<void> addCompletedTask(int taskId, int studentId);

  Future<bool> isCompletedTaskExist(int taskId, int studentId);

  Future<void> deleteCompletedTask(int taskId, int studentId);

  Future<int> getStudentIdFromUserId(int userId);

  Future<int> getTeacherIdFromUserId(int userId);

  Future<int> getGroupIdFromUserId(int userId);

  Future<int> getSubgroupIdFromUserId(int userId);
}
