import 'package:task_service/task_service.dart';

class PostgresTaskFileDataSource implements TaskFileRepository {
  final PostgreSQLConnection connection;

  PostgresTaskFileDataSource(this.connection);

  @override
  Future<TaskFile> createFile(
      {required String name,
      required int size,
      required String url,
      required int userId}) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery(
        'INSERT INTO task_files (user_id, file_name, url, size, created_at) VALUES (@userId, @fileName, @url, @size, @createdAt) RETURNING *',
        substitutionValues: {
          'userId': userId,
          'fileName': name,
          'url': url,
          'size': size,
          'createdAt': DateTime.now(),
        },
      );
      return TaskFile(
          id: result.first['task_files']!['file_id'] as int,
          userId: result.first['task_files']!['user_id'] as int,
          name: result.first['task_files']!['file_name'] as String,
          url: result.first['task_files']!['url'] as String,
          size: result.first['task_files']!['size'] as int,
          createdAt: DateTime.now());
    });
  }

  @override
  Future<void> deleteFile(int id) async {
    connection.mappedResultsQuery(
      'DELETE FROM task_files WHERE file_id = @id',
      substitutionValues: {
        'id': id,
      },
    );
  }

  @override
  Future<List<TaskFile>> getAllFiles(int userId) {
    return connection.mappedResultsQuery(
      'SELECT * FROM task_files WHERE user_id = @userId',
      substitutionValues: {
        'userId': userId,
      },
    ).then((value) {
      if (value.isEmpty) {
        return [];
      }
      return value.map((e) {
        return TaskFile(
            id: e['task_files']!['file_id'] as int,
            userId: e['task_files']!['user_id'] as int,
            name: e['task_files']!['file_name'] as String,
            url: e['task_files']!['url'] as String,
            size: e['task_files']!['size'] as int,
            createdAt: e['task_files']!['created_at'] as DateTime);
      }).toList();
    });
  }

  @override
  Future<TaskFile> getFile(int id) {
    return connection.mappedResultsQuery(
      'SELECT * FROM task_files WHERE file_id = @id',
      substitutionValues: {
        'id': id,
      },
    ).then((value) {
      return TaskFile(
        id: value.first['task_files']!['file_id'] as int,
        userId: value.first['task_files']!['user_id'] as int,
        name: value.first['task_files']!['file_name'] as String,
        url: value.first['task_files']!['url'] as String,
        size: value.first['task_files']!['size'] as int,
        createdAt: value.first['task_files']!['created_at'] as DateTime,
      );
    });
  }

  @override
  Future<TaskFile> updateFile(TaskFile file) {
    return connection.mappedResultsQuery(
      'UPDATE task_files SET file_name = @fileName, url = @url, size = @size, created_at = @createdAt WHERE file_id = @id RETURNING *',
      substitutionValues: {
        'id': file.id,
        'fileName': file.name,
        'url': file.url,
        'size': file.size,
        'createdAt': file.createdAt.toIso8601String(),
      },
    ).then((value) {
      return TaskFile(
        id: value.first['task_files']!['file_id'] as int,
        userId: value.first['task_files']!['user_id'] as int,
        name: value.first['task_files']!['file_name'] as String,
        url: value.first['task_files']!['url'] as String,
        size: value.first['task_files']!['size'] as int,
        createdAt: DateTime.parse(value.first['task_files']!['created_at']),
      );
    });
  }

  @override
  Future<bool> isFileExist(int id) {
    return connection.mappedResultsQuery(
      'SELECT * FROM task_files WHERE file_id = @id',
      substitutionValues: {
        'id': id,
      },
    ).then((value) {
      return value.isNotEmpty;
    });
  }
}
