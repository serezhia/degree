import 'package:task_service/task_service.dart';

class PostgresTagDataSource implements TagRepository {
  final PostgreSQLConnection connection;

  PostgresTagDataSource(this.connection);

  @override
  Future<Tag> createTag(String name) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery(
        'INSERT INTO tags (tag_name) VALUES (@name) RETURNING tag_id, tag_name',
        substitutionValues: {'name': name},
      );
      return Tag(
        result.first['tags']!['tag_id'] as int,
        result.first['tags']!['tag_name'] as String,
      );
    });
  }

  @override
  Future<void> deleteTag(int id) async {
    await connection.transaction((ctx) async {
      await ctx.query(
        'DELETE FROM tags WHERE tag_id = @id',
        substitutionValues: {'id': id},
      );
    });
  }

  @override
  Future<Tag> getTag(int id) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery(
        'SELECT * FROM tags WHERE tag_id = @id',
        substitutionValues: {'id': id},
      );
      return Tag(
        result.first['tags']!['tag_id'] as int,
        result.first['tags']!['tag_name'] as String,
      );
    });
  }

  @override
  Future<List<Tag>> getTags() async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery('SELECT * FROM tags');
      return result.map((e) {
        return Tag(
          e['tags']!['tag_id'] as int,
          e['tags']!['tag_name'] as String,
        );
      }).toList();
    });
  }

  @override
  Future<Tag> updateTag(Tag tag) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery(
          'UPDATE tags SET tag_name = @name WHERE tag_id = @id RETURNING tag_id, tag_name',
          substitutionValues: {
            'id': tag.id,
            'name': tag.name,
          });
      return Tag(
        result.first['tags']!['tag_id'] as int,
        result.first['tags']!['tag_name'] as String,
      );
    });
  }

  @override
  Future<bool> tagExists({String? name, int? id}) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery(
        'SELECT * FROM tags WHERE tag_name = @name OR tag_id = @id',
        substitutionValues: {
          'name': name,
          'id': id,
        },
      );
      return result.isNotEmpty;
    });
  }
}
