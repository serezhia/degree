import 'package:task_service/task_service.dart';

class PostgresTaskDataSource implements TaskRepository {
  final PostgreSQLConnection conection;
  final PostgreSQLConnection scheduleConnection;

  PostgresTaskDataSource(this.conection, this.scheduleConnection);

  @override
  Future<Task> createTask(Task task) async {
    final result = await conection
        .mappedResultsQuery('''INSERT INTO tasks (subject_id, teacher_id, student_id, group_id, subgroup_id, content, deadline_type, deadline)
        VALUES (@subjectId, @teacherId, @studentId, @groupId, @subgroupId, @content, @deadlineType, @deadline) RETURNING *''',
            substitutionValues: {
          'subjectId': task.subjectId,
          'teacherId': task.teacherId,
          'studentId': task.studentId,
          'groupId': task.groupId,
          'subgroupId': task.subgroupId,
          'content': task.content,
          'deadlineType': task.deadlineType.toString(),
          'deadline': task.deadline,
        });

    return Task(
        id: result.first['tasks']!['task_id'] as int,
        subjectId: result.first['tasks']!['subject_id'] as int,
        teacherId: result.first['tasks']!['teacher_id'] as int,
        studentId: result.first['tasks']!['student_id'] as int?,
        groupId: result.first['tasks']!['group_id'] as int?,
        subgroupId: result.first['tasks']!['subgroup_id'] as int?,
        content: result.first['tasks']!['content'] as String,
        deadlineType: DeadlineType.values.firstWhere((el) =>
            el.toString() == '${result.first['tasks']!['deadline_type']!}'),
        deadline: result.first['tasks']!['deadline'] as DateTime?);
  }

  @override
  Future<void> deleteTask(int id) async {
    await conection.query('DELETE FROM tasks WHERE task_id = @id',
        substitutionValues: {'id': id});
  }

  @override
  Future<Task> getTask(int id) async {
    final task = await conection.mappedResultsQuery(
      'SELECT * FROM tasks WHERE task_id = @id',
      substitutionValues: {'id': id},
    );

    final tags = await conection.mappedResultsQuery(
      'SELECT * FROM tags WHERE tag_id IN (SELECT tag_id FROM tasks_tags WHERE task_id = @id)',
      substitutionValues: {'id': id},
    );

    final files = await conection.mappedResultsQuery(
      'SELECT * FROM task_files WHERE file_id IN (SELECT file_id FROM tasks_files WHERE task_id = @id)',
      substitutionValues: {'id': id},
    );

    return Task(
      id: task.first['tasks']!['task_id'] as int,
      subjectId: task.first['tasks']!['subject_id'] as int,
      teacherId: task.first['tasks']!['teacher_id'] as int,
      studentId: task.first['tasks']!['student_id'] as int?,
      groupId: task.first['tasks']!['group_id'] as int?,
      subgroupId: task.first['tasks']!['subgroup_id'] as int?,
      content: task.first['tasks']!['content'] as String,
      deadlineType: DeadlineType.values.firstWhere(
          (el) => el.toString() == '${task.first['tasks']!['deadline_type']!}'),
      deadline: task.first['tasks']!['deadline'] as DateTime?,
      tags: tags
          .map((e) => Tag(
                e['tags']!['tag_id'] as int,
                e['tags']!['tag_name'],
              ))
          .toList(),
      files: files
          .map((e) => TaskFile(
                id: e['task_files']!['file_id'] as int,
                userId: e['task_files']!['user_id'] as int,
                name: e['task_files']!['file_name'] as String,
                url: e['task_files']!['url'] as String,
                size: e['task_files']!['size'] as int,
                createdAt: e['task_files']!['created_at'] as DateTime,
              ))
          .toList(),
    );
  }

  @override
  Future<List<Task>> getTasks() async {
    final tasks = await conection.mappedResultsQuery(
      'SELECT * FROM tasks',
    );

    for (var element in tasks) {
      final tags = await conection.mappedResultsQuery(
        'SELECT * FROM tags WHERE tag_id IN (SELECT tag_id FROM tasks_tags WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );

      final files = await conection.mappedResultsQuery(
        'SELECT * FROM task_files WHERE file_id IN (SELECT file_id FROM tasks_files WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );

      element['tasks']!['tags'] = tags
          .map((e) => Tag(
                e['tags']!['tag_id'] as int,
                e['tags']!['tag_name'],
              ))
          .toList();

      element['tasks']!['files'] = files
          .map((e) => TaskFile(
                id: e['task_files']!['file_id'] as int,
                userId: e['task_files']!['user_id'] as int,
                name: e['task_files']!['file_name'] as String,
                url: e['task_files']!['url'] as String,
                size: e['task_files']!['size'] as int,
                createdAt: e['task_files']!['created_at'] as DateTime,
              ))
          .toList();
    }
    return tasks
        .map((e) => Task(
              id: e['tasks']!['task_id'] as int,
              subjectId: e['tasks']!['subject_id'] as int,
              teacherId: e['tasks']!['teacher_id'] as int,
              studentId: e['tasks']!['student_id'] as int?,
              groupId: e['tasks']!['group_id'] as int?,
              subgroupId: e['tasks']!['subgroup_id'] as int?,
              content: e['tasks']!['content'] as String,
              deadlineType: DeadlineType.values.firstWhere(
                  (el) => el.toString() == '${e['tasks']!['deadline_type']!}'),
              deadline: e['tasks']!['deadline'] as DateTime?,
              tags: e['tasks']!['tags'] as List<Tag>,
              files: e['tasks']!['files'] as List<TaskFile>,
            ))
        .toList();
  }

  @override
  Future<List<Task>> getTasksByGroupId(int groupId) async {
    final tasks = await conection.mappedResultsQuery(
      'SELECT * FROM tasks WHERE group_id = @id',
      substitutionValues: {'id': groupId},
    );

    for (var element in tasks) {
      final tags = await conection.mappedResultsQuery(
        'SELECT * FROM tags WHERE tag_id IN (SELECT tag_id FROM tasks_tags WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );

      final files = await conection.mappedResultsQuery(
        'SELECT * FROM task_files WHERE file_id IN (SELECT file_id FROM tasks_files WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );

      element['tasks']!['tags'] = tags
          .map((e) => Tag(
                e['tags']!['tag_id'] as int,
                e['tags']!['tag_name'],
              ))
          .toList();

      element['tasks']!['files'] = files
          .map((e) => TaskFile(
                id: e['task_files']!['file_id'] as int,
                userId: e['task_files']!['user_id'] as int,
                name: e['task_files']!['file_name'] as String,
                url: e['task_files']!['url'] as String,
                size: e['task_files']!['size'] as int,
                createdAt: e['task_files']!['created_at'] as DateTime,
              ))
          .toList();
    }
    return tasks
        .map((e) => Task(
              id: e['tasks']!['task_id'] as int,
              subjectId: e['tasks']!['subject_id'] as int,
              teacherId: e['tasks']!['teacher_id'] as int,
              studentId: e['tasks']!['student_id'] as int?,
              groupId: e['tasks']!['group_id'] as int?,
              subgroupId: e['tasks']!['subgroup_id'] as int?,
              content: e['tasks']!['content'] as String,
              deadlineType: DeadlineType.values.firstWhere(
                  (el) => el.toString() == '${e['tasks']!['deadline_type']!}'),
              deadline: e['tasks']!['deadline'] as DateTime?,
              tags: e['tasks']!['tags'] as List<Tag>,
              files: e['tasks']!['files'] as List<TaskFile>,
            ))
        .toList();
  }

  @override
  Future<List<Task>> getTasksByStudent(
      int studentId, int groupId, int subgroupId) async {
    final tasks = await conection.mappedResultsQuery(
      'SELECT * FROM tasks WHERE student_id = @id OR group_id = @group_id OR subgroup_id = @subgroup_id',
      substitutionValues: {
        'id': studentId,
        'group_id': groupId,
        'subgroup_id': subgroupId,
      },
    );

    for (var element in tasks) {
      final tags = await conection.mappedResultsQuery(
        'SELECT * FROM tags WHERE tag_id IN (SELECT tag_id FROM tasks_tags WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );

      final files = await conection.mappedResultsQuery(
        'SELECT * FROM task_files WHERE file_id IN (SELECT file_id FROM tasks_files WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );
      final isDone = await conection.mappedResultsQuery(
        'SELECT * FROM students_complete WHERE task_id = @id AND student_id = @student_id',
        substitutionValues: {
          'id': element['tasks']!['task_id'],
          'student_id': studentId,
        },
      );

      element['tasks']!['isDone'] = isDone.isNotEmpty;

      element['tasks']!['tags'] = tags
          .map((e) => Tag(
                e['tags']!['tag_id'] as int,
                e['tags']!['tag_name'],
              ))
          .toList();

      element['tasks']!['files'] = files
          .map((e) => TaskFile(
                id: e['task_files']!['file_id'] as int,
                userId: e['task_files']!['user_id'] as int,
                name: e['task_files']!['file_name'] as String,
                url: e['task_files']!['url'] as String,
                size: e['task_files']!['size'] as int,
                createdAt: e['task_files']!['created_at'] as DateTime,
              ))
          .toList();
    }
    return tasks
        .map((e) => Task(
              id: e['tasks']!['task_id'] as int,
              subjectId: e['tasks']!['subject_id'] as int,
              teacherId: e['tasks']!['teacher_id'] as int,
              studentId: e['tasks']!['student_id'] as int?,
              groupId: e['tasks']!['group_id'] as int?,
              subgroupId: e['tasks']!['subgroup_id'] as int?,
              content: e['tasks']!['content'] as String,
              deadlineType: DeadlineType.values.firstWhere(
                  (el) => el.toString() == '${e['tasks']!['deadline_type']!}'),
              deadline: e['tasks']!['deadline'] as DateTime?,
              tags: e['tasks']!['tags'] as List<Tag>,
              files: e['tasks']!['files'] as List<TaskFile>,
              isDone: e['tasks']!['isDone'] as bool,
            ))
        .toList();
  }

  @override
  Future<List<Task>> getTasksDayByTeacher(DateTime day, int teacherId) async {
    final tasks = await conection.mappedResultsQuery(
      'SELECT * FROM tasks WHERE teacher_id = @id AND deadline = @day',
      substitutionValues: {
        'id': teacherId,
        'day': day,
      },
    );

    for (var element in tasks) {
      final tags = await conection.mappedResultsQuery(
        'SELECT * FROM tags WHERE tag_id IN (SELECT tag_id FROM tasks_tags WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );

      final files = await conection.mappedResultsQuery(
        'SELECT * FROM task_files WHERE file_id IN (SELECT file_id FROM tasks_files WHERE task_id = @id)',
        substitutionValues: {'id': element['tasks']!['task_id']},
      );

      element['tasks']!['tags'] = tags
          .map((e) => Tag(
                e['tags']!['tag_id'] as int,
                e['tags']!['tag_name'],
              ))
          .toList();

      element['tasks']!['files'] = files
          .map((e) => TaskFile(
                id: e['task_files']!['file_id'] as int,
                userId: e['task_files']!['user_id'] as int,
                name: e['task_files']!['file_name'] as String,
                url: e['task_files']!['url'] as String,
                size: e['task_files']!['size'] as int,
                createdAt: e['task_files']!['created_at'] as DateTime,
              ))
          .toList();
    }
    return tasks
        .map((e) => Task(
              id: e['tasks']!['task_id'] as int,
              subjectId: e['tasks']!['subject_id'] as int,
              teacherId: e['tasks']!['teacher_id'] as int,
              studentId: e['tasks']!['student_id'] as int?,
              groupId: e['tasks']!['group_id'] as int?,
              subgroupId: e['tasks']!['subgroup_id'] as int?,
              content: e['tasks']!['content'] as String,
              deadlineType: DeadlineType.values.firstWhere(
                  (el) => el.toString() == '${e['tasks']!['deadline_type']!}'),
              deadline: e['tasks']!['deadline'] as DateTime?,
              tags: e['tasks']!['tags'] as List<Tag>,
              files: e['tasks']!['files'] as List<TaskFile>,
            ))
        .toList();
  }

  @override
  Future<Task> updateTask(Task task) {
    return conection.mappedResultsQuery(
      'UPDATE tasks SET subject_id = @subjectId, teacher_id = @teacherId, student_id = @studentId, group_id = @groupId, subgroup_id = @subgroupId, content = @content, deadline_type = @deadlineType, deadline = @deadline WHERE task_id = @taskId RETURNING *',
      substitutionValues: {
        'taskId': task.id,
        'subjectId': task.subjectId,
        'teacherId': task.teacherId,
        'studentId': task.studentId,
        'groupId': task.groupId,
        'subgroupId': task.subgroupId,
        'content': task.content,
        'deadlineType': task.deadlineType.toString(),
        'deadline': task.deadline,
      },
    ).then((value) => Task(
          id: value.first['tasks']!['task_id'] as int,
          subjectId: value.first['tasks']!['subject_id'] as int,
          teacherId: value.first['tasks']!['teacher_id'] as int,
          studentId: value.first['tasks']!['student_id'] as int?,
          groupId: value.first['tasks']!['group_id'] as int?,
          subgroupId: value.first['tasks']!['subgroup_id'] as int?,
          content: value.first['tasks']!['content'] as String,
          deadlineType: DeadlineType.values.firstWhere((el) =>
              el.toString() == '${value.first['tasks']!['deadline_type']!}'),
          deadline: value.first['tasks']!['deadline'] as DateTime?,
        ));
  }

  @override
  Future<void> addFile(int taskId, int fileId) async {
    await conection.mappedResultsQuery(
      'INSERT INTO tasks_files (task_id, file_id) VALUES (@taskId, @fileId) RETURNING *',
      substitutionValues: {
        'taskId': taskId,
        'fileId': fileId,
      },
    );
  }

  @override
  Future<void> addTag(int taskId, int tagId) async {
    await conection.mappedResultsQuery(
      'INSERT INTO tasks_tags (task_id, tag_id) VALUES (@taskId, @tagId) RETURNING *',
      substitutionValues: {
        'taskId': taskId,
        'tagId': tagId,
      },
    );
  }

  @override
  Future<void> deleteFile(int taskId, int fileId) async {
    await conection.mappedResultsQuery(
      'DELETE FROM tasks_files WHERE task_id = @taskId AND file_id = @fileId',
      substitutionValues: {
        'taskId': taskId,
        'fileId': fileId,
      },
    );
  }

  @override
  Future<void> deleteTag(int taskId, int tagId) async {
    await conection.mappedResultsQuery(
      'DELETE FROM tasks_tags WHERE task_id = @taskId AND tag_id = @tagId',
      substitutionValues: {
        'taskId': taskId,
        'tagId': tagId,
      },
    );
  }

  @override
  Future<bool> existsTask(int id) {
    return conection.mappedResultsQuery(
      'SELECT * FROM tasks WHERE task_id = @id',
      substitutionValues: {'id': id},
    ).then((value) => value.isNotEmpty);
  }

  @override
  Future<bool> isFileExist(int taskId, int fileId) {
    return conection.mappedResultsQuery(
      'SELECT * FROM tasks_files WHERE task_id = @taskId AND file_id = @fileId',
      substitutionValues: {
        'taskId': taskId,
        'fileId': fileId,
      },
    ).then((value) => value.isNotEmpty);
  }

  @override
  Future<bool> isTagExist(int taskId, int tagId) {
    return conection.mappedResultsQuery(
      'SELECT * FROM tasks_tags WHERE task_id = @taskId AND tag_id = @tagId',
      substitutionValues: {
        'taskId': taskId,
        'tagId': tagId,
      },
    ).then((value) => value.isNotEmpty);
  }

  @override
  Future<void> addCompletedTask(int taskId, int studentId) async {
    await conection.mappedResultsQuery(
      'INSERT INTO students_complete (task_id, student_id, is_complete) VALUES (@taskId, @studentId, @isComplete) RETURNING *',
      substitutionValues: {
        'taskId': taskId,
        'studentId': studentId,
        'isComplete': true,
      },
    );
  }

  @override
  Future<void> deleteCompletedTask(int taskId, int studentId) async {
    await conection.mappedResultsQuery(
      'DELETE FROM students_complete WHERE task_id = @taskId AND student_id = @studentId',
      substitutionValues: {
        'taskId': taskId,
        'studentId': studentId,
      },
    );
  }

  @override
  Future<bool> isCompletedTaskExist(int taskId, int studentId) {
    return conection.mappedResultsQuery(
      'SELECT * FROM students_complete WHERE task_id = @taskId AND student_id = @studentId',
      substitutionValues: {
        'taskId': taskId,
        'studentId': studentId,
      },
    ).then((value) => value.isNotEmpty);
  }

  @override
  Future<int> getGroupIdFromUserId(int userId) {
    return scheduleConnection.mappedResultsQuery(
      'SELECT group_id FROM students WHERE user_id = @userId',
      substitutionValues: {
        'userId': userId,
      },
    ).then((value) => value.first['students']!['group_id'] as int);
  }

  @override
  Future<int> getStudentIdFromUserId(int userId) {
    return scheduleConnection.mappedResultsQuery(
      'SELECT student_id FROM students WHERE user_id = @userId',
      substitutionValues: {
        'userId': userId,
      },
    ).then((value) => value.first['students']!['student_id'] as int);
  }

  @override
  Future<int> getSubgroupIdFromUserId(int userId) {
    return scheduleConnection.mappedResultsQuery(
      'SELECT subgroup_id FROM students WHERE user_id = @userId',
      substitutionValues: {
        'userId': userId,
      },
    ).then((value) => value.first['students']!['subgroup_id'] as int);
  }

  @override
  Future<int> getTeacherIdFromUserId(int userId) {
    return scheduleConnection.mappedResultsQuery(
      'SELECT teacher_id FROM teachers WHERE user_id = @userId',
      substitutionValues: {
        'userId': userId,
      },
    ).then((value) => value.first['teachers']!['teacher_id'] as int);
  }
}
