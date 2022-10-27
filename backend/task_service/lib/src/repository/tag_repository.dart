import 'package:task_service/task_service.dart';

abstract class TagRepository {
  Future<List<Tag>> getTags();

  Future<Tag> getTag(int id);

  Future<Tag> createTag(String name);

  Future<Tag> updateTag(Tag tag);

  Future<void> deleteTag(int id);

  Future<bool> tagExists({String? name, int? id});
}
