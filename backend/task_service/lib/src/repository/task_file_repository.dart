import 'package:task_service/task_service.dart';

abstract class TaskFileRepository {
  Future<TaskFile> createFile(
      {required int userId,
      required String name,
      required String url,
      required int size});

  Future<TaskFile> getFile(int id);

  Future<List<TaskFile?>> getAllFiles(int userId);

  Future<TaskFile> updateFile(TaskFile file);

  Future<void> deleteFile(int id);

  Future<bool> isFileExist(int id);
}
