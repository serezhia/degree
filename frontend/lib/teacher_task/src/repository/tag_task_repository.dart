import '../../teacher_task.dart';

abstract class TagTaskRepository {
  Future<List<TagTask>> getTagTasks();

  Future<TagTask> getTagTask(int id);

  Future<void> addTagTask(String name);

  Future<void> updateTagTask(TagTask tagTask);

  Future<void> deleteTagTask(int id);
}
