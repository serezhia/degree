import 'package:task_service/task_service.dart';

class TasksRoute {
  final TaskRepository taskRepository;
  final TagRepository tagRepository;
  final TaskFileRepository fileRepository;

  TasksRoute(
      {required this.tagRepository,
      required this.fileRepository,
      required this.taskRepository});

  Handler get router {
    final router = Router();

    router.post('/', (Request req) async {
      final role = req.context['role'] as String;

      final params = req.url.queryParameters;
      final subjectId = params['subject_id'];
      final teacherId = params['teacher_id'];
      final studentId = params['student_id'];
      final groupId = params['group_id'];
      final subgroupId = params['subgroup_id'];
      final content = params['content'];
      final deadlineType = params['deadline_type'];
      final deadline = params['deadline'];

      if (role == 'student') {
        return Response.forbidden('You don\'t have permission to do this');
      }

      if (subjectId == null ||
          teacherId == null ||
          content == null ||
          deadlineType == null) {
        return Response.badRequest(
            body:
                'subject_id, teacher_id, content, deadline_type are required');
      }

      if (deadlineType == DeadlineType.date.toString().split('.').last) {
        if (deadline == null) {
          return Response.badRequest(body: 'deadline is required');
        }
      } else if (deadlineType !=
          DeadlineType.nextLesson.toString().split('.').last) {
        return Response.badRequest(body: 'deadline_type is invalid');
      }

      if ((studentId == null) & (subgroupId == null) & (groupId == null)) {
        return Response.badRequest(
            body: 'student_id or subgroup_id or group_id are required');
      }

      final Task task = Task(
        subjectId: int.parse(subjectId),
        teacherId: int.parse(teacherId),
        studentId: studentId != null ? int.parse(studentId) : null,
        groupId: groupId != null ? int.parse(groupId) : null,
        subgroupId: subgroupId != null ? int.parse(subgroupId) : null,
        content: content,
        deadlineType: DeadlineType.values
            .firstWhere((e) => e.toString().split('.').last == deadlineType),
        deadline: deadline != null ? DateTime.parse(deadline) : null,
        tags: null,
        files: null,
        isDone: null,
      );
      final createdTask = await taskRepository.createTask(task);

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task created',
        'task': {
          'task_id': createdTask.id,
          'subject_id': createdTask.subjectId,
          'teacher_id': createdTask.teacherId,
          'student_id': createdTask.studentId,
          'group_id': createdTask.groupId,
          'subgroup_id': createdTask.subgroupId,
          'content': createdTask.content,
          'deadline_type': createdTask.deadlineType.toString().split('.').last,
          'deadline': createdTask.deadline?.toIso8601String(),
          'tags': createdTask.tags
              ?.map((e) => {
                    'tag_id': e.id,
                    'name': e.name,
                  })
              .toList(),
          'files': createdTask.files
              ?.map((e) => {
                    'file_id': e.id,
                    'user_id': e.userId,
                    'name': e.name,
                    'file_url': e.url,
                    'size': e.size,
                    'created_at': e.createdAt.toIso8601String(),
                  })
              .toList(),
        },
      }));
    });

    router.get('/<id>', (Request req, String taskId) async {
      if (!await taskRepository.existsTask(int.parse(taskId))) {
        return Response.notFound('Task not found');
      }

      final task = await taskRepository.getTask(int.parse(taskId));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task found',
        'task': {
          'task_id': task.id,
          'subject_id': task.subjectId,
          'teacher_id': task.teacherId,
          'student_id': task.studentId,
          'group_id': task.groupId,
          'subgroup_id': task.subgroupId,
          'content': task.content,
          'deadline_type': task.deadlineType.toString().split('.').last,
          'deadline': task.deadline?.toIso8601String(),
          'tags': task.tags
              ?.map((e) => {
                    'tag_id': e.id,
                    'name': e.name,
                  })
              .toList(),
          'files': task.files
              ?.map((e) => {
                    'file_id': e.id,
                    'user_id': e.userId,
                    'name': e.name,
                    'file_url': e.url,
                    'size': e.size,
                    'created_at': e.createdAt.toIso8601String(),
                  })
              .toList(),
        },
      }));
    });

    router.get('/', (Request req) async {
      final tasks = await taskRepository.getTasks();
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task found',
        'tasks': tasks
            .map((e) => {
                  'task_id': e.id,
                  'subject_id': e.subjectId,
                  'teacher_id': e.teacherId,
                  'student_id': e.studentId,
                  'group_id': e.groupId,
                  'subgroup_id': e.subgroupId,
                  'content': e.content,
                  'deadline_type': e.deadlineType.toString().split('.').last,
                  'deadline': e.deadline?.toIso8601String(),
                  'tags': e.tags
                      ?.map((e) => {
                            'tag_id': e.id,
                            'name': e.name,
                          })
                      .toList(),
                  'files': e.files
                      ?.map((e) => {
                            'file_id': e.id,
                            'user_id': e.userId,
                            'name': e.name,
                            'file_url': e.url,
                            'size': e.size,
                            'created_at': e.createdAt.toIso8601String(),
                          })
                      .toList(),
                })
            .toList(),
      }));
    });

    router.post('/files/<taskId>/<fileId>',
        (Request req, String taskId, String fileId) async {
      final role = req.context['role'] as String;

      if (role == 'student') {
        return Response.forbidden('You don\'t have permission to do this');
      }

      if (!await taskRepository.existsTask(int.parse(taskId))) {
        return Response.badRequest(body: 'Task not found');
      }

      if (!await fileRepository.isFileExist(int.parse(fileId))) {
        return Response.badRequest(body: 'File not found');
      }

      if (await taskRepository.isFileExist(
          int.parse(taskId), int.parse(fileId))) {
        return Response.badRequest(body: 'File already exists');
      }

      await taskRepository.addFile(int.parse(taskId), int.parse(fileId));

      return Response.ok('File added to task');
    });

    router.delete('/files/<taskId>/<fileId>',
        (Request req, String taskId, String fileId) async {
      final role = req.context['role'] as String;

      if (role == 'student') {
        return Response.forbidden('You don\'t have permission to do this');
      }

      if (!await taskRepository.existsTask(int.parse(taskId))) {
        return Response.badRequest(body: 'Task not found');
      }

      if (!await fileRepository.isFileExist(int.parse(fileId))) {
        return Response.badRequest(body: 'File not found');
      }

      if (!await taskRepository.isFileExist(
          int.parse(taskId), int.parse(fileId))) {
        return Response.badRequest(body: 'File not found in task');
      }

      await taskRepository.deleteFile(int.parse(taskId), int.parse(fileId));
      return Response.ok('File deleted from task');
    });

    router.post('/tags/<taskId>/<tagId>',
        (Request req, String taskId, String tagId) async {
      final role = req.context['role'] as String;

      if (role == 'student') {
        return Response.forbidden('You don\'t have permission to do this');
      }

      if (!await taskRepository.existsTask(int.parse(taskId))) {
        return Response.badRequest(body: 'Task not found');
      }

      if (!await tagRepository.tagExists(id: int.parse(tagId))) {
        return Response.badRequest(body: 'Tag not found');
      }

      if (await taskRepository.isTagExist(
          int.parse(taskId), int.parse(tagId))) {
        return Response.badRequest(body: 'Tag already exists');
      }

      await taskRepository.addTag(int.parse(taskId), int.parse(tagId));

      return Response.ok('Tag added to task');
    });

    router.delete('/tags/<taskId>/<tagId>',
        (Request req, String taskId, String tagId) async {
      final role = req.context['role'] as String;

      if (role == 'student') {
        return Response.forbidden('You don\'t have permission to do this');
      }

      if (!await taskRepository.existsTask(int.parse(taskId))) {
        return Response.badRequest(body: 'Task not found');
      }

      if (!await tagRepository.tagExists(id: int.parse(tagId))) {
        return Response.badRequest(body: 'Tag not found');
      }

      if (!await taskRepository.isTagExist(
          int.parse(taskId), int.parse(tagId))) {
        return Response.badRequest(body: 'Tag not found in task');
      }

      await taskRepository.deleteTag(int.parse(taskId), int.parse(tagId));
      return Response.ok('Tag deleted from task');
    });

    router.get('/student/', (Request req) async {
      final userIdString = req.context['user_id'] as String;

      final userId = int.parse(userIdString);

      final int studentId;
      try {
        studentId = await taskRepository.getStudentIdFromUserId(userId);
      } catch (e) {
        return Response.badRequest(body: 'Student not found in database  $e');
      }

      final int groupId;

      try {
        groupId = await taskRepository.getGroupIdFromUserId(userId);
      } catch (e) {
        return Response.badRequest(body: 'Group not found in database  $e');
      }

      final int subgroupId;

      try {
        subgroupId = await taskRepository.getSubgroupIdFromUserId(userId);
      } catch (e) {
        return Response.badRequest(body: 'Subgroup not found in database  $e');
      }

      final tasks = await taskRepository.getTasksByStudent(
          studentId, groupId, subgroupId);

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task found',
        'tasks': tasks
            .map((e) => {
                  'task_id': e.id,
                  'subject_id': e.subjectId,
                  'teacher_id': e.teacherId,
                  'student_id': e.studentId,
                  'group_id': e.groupId,
                  'subgroup_id': e.subgroupId,
                  'content': e.content,
                  'deadline_type': e.deadlineType.toString().split('.').last,
                  'deadline': e.deadline?.toIso8601String(),
                  'isDone': e.isDone,
                  'tags': e.tags
                      ?.map((e) => {
                            'tag_id': e.id,
                            'name': e.name,
                          })
                      .toList(),
                  'files': e.files
                      ?.map((e) => {
                            'file_id': e.id,
                            'user_id': e.userId,
                            'name': e.name,
                            'file_url': e.url,
                            'size': e.size,
                            'created_at': e.createdAt.toIso8601String(),
                          })
                      .toList(),
                })
            .toList(),
      }));
    });

    /// GET TEACHER TASKS

    router.get('/teacher/', (Request req) async {
      final userIdString = req.context['user_id'] as String;

      final userId = int.parse(userIdString);

      final int teacherId;
      try {
        teacherId = await taskRepository.getTeacherIdFromUserId(userId);
      } catch (e) {
        return Response.badRequest(body: 'Teacher not found in database  $e');
      }

      final tasks = await taskRepository.getTasksByTeacherId(teacherId);

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task found',
        'tasks': tasks
            .map((e) => {
                  'task_id': e.id,
                  'subject_id': e.subjectId,
                  'teacher_id': e.teacherId,
                  'student_id': e.studentId,
                  'group_id': e.groupId,
                  'subgroup_id': e.subgroupId,
                  'content': e.content,
                  'deadline_type': e.deadlineType.toString().split('.').last,
                  'deadline': e.deadline?.toIso8601String(),
                  'tags': e.tags
                      ?.map((e) => {
                            'tag_id': e.id,
                            'name': e.name,
                          })
                      .toList(),
                  'files': e.files
                      ?.map((e) => {
                            'file_id': e.id,
                            'user_id': e.userId,
                            'name': e.name,
                            'file_url': e.url,
                            'size': e.size,
                            'created_at': e.createdAt.toIso8601String(),
                          })
                      .toList(),
                })
            .toList(),
      }));
    });

    router.post('/complete/<taskId>', (Request req, String taskId) async {
      final userIdString = req.context['user_id'] as String;

      final userId = int.parse(userIdString);
      print(userId);
      final int studentId;
      try {
        studentId = await taskRepository.getStudentIdFromUserId(userId);
      } catch (e) {
        return Response.badRequest(body: 'Student not found in database  $e');
      }

      await taskRepository.addCompletedTask(int.parse(taskId), studentId);

      return Response.ok('Task completed');
    });

    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);

    return handler;
  }
}
