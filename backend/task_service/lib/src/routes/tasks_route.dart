import 'dart:developer' as developer;

import 'package:dio/dio.dart' as dio;
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
      final userIdString = req.context['user_id'] as String;
      final accessToken = req.context['access_token'];
      final params = req.url.queryParameters;

      final int? teacherId;
      if (role == 'teacher') {
        final userId = int.parse(userIdString);
        try {
          teacherId = await taskRepository.getTeacherIdFromUserId(userId);
        } catch (e) {
          return Response.badRequest(body: 'Teacher not found in database  $e');
        }
      } else if (role == 'admin') {
        teacherId = params['teacher_id']! as int?;
      } else {
        return Response.forbidden('Forbidden');
      }

      final teacherResponse = await dio.Dio().get(
        'http://${scheduleServiceHost()}:${scheduleServicePort()}/teachers/$teacherId?access_token=$accessToken',
      );

      final teacherData =
          jsonDecode(teacherResponse.data) as Map<String, dynamic>;

      final teacher = <String, dynamic>{
        'user_id': teacherData['teacher']!['user_id'] as int,
        'teacher_id': teacherData['teacher']!['id'] as int,
        'firstName': teacherData['teacher']!['first_name'] as String,
        'secondName': teacherData['teacher']!['second_name'] as String,
        if (teacherData['teacher']!['middle_name'] != null)
          'middleName': teacherData['teacher']!['middle_name'] as String,
      };

      final subjectId = params['subject_id'];
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
        teacherId: teacherId,
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
          'teacher': teacher,
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
      final accessToken = req.context['access_token'];
      if (!await taskRepository.existsTask(int.parse(taskId))) {
        return Response.notFound('Task not found');
      }

      final task = await taskRepository.getTask(int.parse(taskId));

      late final Map<String, dynamic> subject;
      try {
        final subjectResponse = await dio.Dio().get(
            'http://${scheduleServiceHost()}:${scheduleServicePort()}/subjects/${task.subjectId}?access_token=$accessToken');
        final subjectData =
            jsonDecode(subjectResponse.data) as Map<String, dynamic>;
        subject = <String, dynamic>{
          'id': subjectData['subject']!['id'] as int,
          'name': subjectData['subject']!['name'] as String,
        };
      } catch (e) {
        developer.log('Error while getting subject from schedule service',
            error: e);
      }

      final teacherResponse = await dio.Dio().get(
          'http://${scheduleServiceHost()}:${scheduleServicePort()}/teachers/${task.teacherId}?access_token=$accessToken');

      final teacherData =
          jsonDecode(teacherResponse.data) as Map<String, dynamic>;

      final teacher = <String, dynamic>{
        'user_id': teacherData['teacher']!['user_id'] as int,
        'teacher_id': teacherData['teacher']!['id'] as int,
        'firstName': teacherData['teacher']!['first_name'] as String,
        'secondName': teacherData['teacher']!['second_name'] as String,
        if (teacherData['teacher']!['middle_name'] != null)
          'middleName': teacherData['teacher']!['middle_name'] as String,
      };

      late final Map<String, dynamic> group;
      if (task.groupId != null) {
        final groupResponse = await dio.Dio().get(
            'http://${scheduleServiceHost()}:${scheduleServicePort()}/groups/${task.groupId}?access_token=$accessToken');

        final groupData =
            jsonDecode(groupResponse.data) as Map<String, dynamic>;

        group = <String, dynamic>{
          'id': groupData['Group']!['id'] as int,
          'name': groupData['Group']!['name'] as String,
        };
      }

      late final Map<String, dynamic> subgroup;
      if (task.subgroupId != null) {
        final subgroupResponse = await dio.Dio().get(
            'http://${scheduleServiceHost()}:${scheduleServicePort()}/subgroups/${task.subgroupId}?access_token=$accessToken');

        final subgroupData =
            jsonDecode(subgroupResponse.data) as Map<String, dynamic>;

        subgroup = <String, dynamic>{
          'id': subgroupData['subgroup']!['id'] as int,
          'name': subgroupData['subgroup']!['name'] as String,
        };
      }

      late final Map<String, dynamic> student;

      if (task.studentId != null) {
        final studentResponse = await dio.Dio().get(
            'http://${scheduleServiceHost()}:${scheduleServicePort()}/students/${task.studentId}?access_token=$accessToken');

        final studentData =
            jsonDecode(studentResponse.data) as Map<String, dynamic>;

        student = <String, dynamic>{
          'user_id': studentData['student']!['user_id'] as int,
          'id': studentData['student']!['id'] as int,
          'firstName': studentData['student']!['firstName'] as String,
          'secondName': studentData['student']!['secondName'] as String,
          if (studentData['student']!['middleName'] != null)
            'middleName': studentData['student']!['middleName'] as String,
        };
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task found',
        'task': {
          'task_id': task.id,
          'subject': subject,
          'teacher': teacher,
          if (task.studentId != null) 'student': student,
          if (task.groupId != null) 'group': group,
          if (task.subgroupId != null) 'subgroup': subgroup,
          'content': task.content,
          'deadline_type': task.deadlineType.toString().split('.').last,
          'deadline': task.deadline?.toIso8601String(),
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

    router.get('/student/<isDone>', (Request req, String isDone) async {
      final userIdString = req.context['user_id'] as String;
      final accessToken = req.context['access_token'];
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

      final List<Task> tasksData = [];
      final tasks = [];
      if (isDone == 'true') {
        tasksData.addAll((await taskRepository.getTasksByStudent(
                studentId, groupId, subgroupId))
            .where((element) => element.isDone == true));
      } else {
        tasksData.addAll((await taskRepository.getTasksByStudent(
                studentId, groupId, subgroupId))
            .where((element) =>
                element.isDone == null || element.isDone == false));
      }

      for (var task in tasksData) {
        late final Map<String, dynamic> subject;
        try {
          final subjectResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/subjects/${task.subjectId}?access_token=$accessToken');
          final subjectData =
              jsonDecode(subjectResponse.data) as Map<String, dynamic>;
          subject = <String, dynamic>{
            'id': subjectData['subject']!['id'] as int,
            'name': subjectData['subject']!['name'] as String,
          };
        } catch (e) {
          developer.log('Error while getting subject from schedule service',
              error: e);
        }

        final teacherResponse = await dio.Dio().get(
            'http://${scheduleServiceHost()}:${scheduleServicePort()}/teachers/${task.teacherId}?access_token=$accessToken');

        final teacherData =
            jsonDecode(teacherResponse.data) as Map<String, dynamic>;

        final teacher = <String, dynamic>{
          'user_id': teacherData['teacher']!['user_id'] as int,
          'teacher_id': teacherData['teacher']!['id'] as int,
          'firstName': teacherData['teacher']!['first_name'] as String,
          'secondName': teacherData['teacher']!['second_name'] as String,
          if (teacherData['teacher']!['middle_name'] != null)
            'middleName': teacherData['teacher']!['middle_name'] as String,
        };

        late final Map<String, dynamic> group;
        if (task.groupId != null) {
          final groupResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/groups/${task.groupId}?access_token=$accessToken');

          final groupData =
              jsonDecode(groupResponse.data) as Map<String, dynamic>;

          group = <String, dynamic>{
            'id': groupData['Group']!['id'] as int,
            'name': groupData['Group']!['name'] as String,
          };
        }

        late final Map<String, dynamic> subgroup;
        if (task.subgroupId != null) {
          final subgroupResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/subgroups/${task.subgroupId}?access_token=$accessToken');

          final subgroupData =
              jsonDecode(subgroupResponse.data) as Map<String, dynamic>;

          subgroup = <String, dynamic>{
            'id': subgroupData['subgroup']!['id'] as int,
            'name': subgroupData['subgroup']!['name'] as String,
          };
        }

        late final Map<String, dynamic> student;

        if (task.studentId != null) {
          final studentResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/students/${task.studentId}?access_token=$accessToken');

          final studentData =
              jsonDecode(studentResponse.data) as Map<String, dynamic>;

          student = <String, dynamic>{
            'user_id': studentData['student']!['user_id'] as int,
            'id': studentData['student']!['id'] as int,
            'firstName': studentData['student']!['firstName'] as String,
            'secondName': studentData['student']!['secondName'] as String,
            if (studentData['student']!['middleName'] != null)
              'middleName': studentData['student']!['middleName'] as String,
          };
        }

        tasks.add({
          'task_id': task.id,
          'subject': subject,
          'teacher': teacher,
          if (task.groupId != null) 'group': group,
          if (task.subgroupId != null) 'subgroup': subgroup,
          if (task.studentId != null) 'student': student,
          'content': task.content,
          'deadline_type': task.deadlineType.toString().split('.').last,
          'deadline': task.deadline?.toIso8601String(),
        });
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task found',
        'tasks': tasks,
      }));
    });

    /// GET TEACHER TASKS

    router.get('/teacher/<day>', (Request req, String day) async {
      final userIdString = req.context['user_id'] as String;

      final userId = int.parse(userIdString);
      final accessToken = req.context['access_token'];
      final int teacherId;
      try {
        teacherId = await taskRepository.getTeacherIdFromUserId(userId);
      } catch (e) {
        return Response.badRequest(body: 'Teacher not found in database  $e');
      }

      final tasksData = await taskRepository.getTasksDayByTeacher(
        DateTime.parse(day),
        teacherId,
      );

      final tasks = [];

      for (var task in tasksData) {
        late final Map<String, dynamic> subject;
        try {
          final subjectResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/subjects/${task.subjectId}?access_token=$accessToken');
          final subjectData =
              jsonDecode(subjectResponse.data) as Map<String, dynamic>;
          subject = <String, dynamic>{
            'id': subjectData['subject']!['id'] as int,
            'name': subjectData['subject']!['name'] as String,
          };
        } catch (e) {
          developer.log('Error while getting subject from schedule service',
              error: e);
        }

        final teacherResponse = await dio.Dio().get(
            'http://${scheduleServiceHost()}:${scheduleServicePort()}/teachers/$teacherId?access_token=$accessToken');

        final teacherData =
            jsonDecode(teacherResponse.data) as Map<String, dynamic>;

        final teacher = <String, dynamic>{
          'user_id': teacherData['teacher']!['user_id'] as int,
          'teacher_id': teacherData['teacher']!['id'] as int,
          'firstName': teacherData['teacher']!['first_name'] as String,
          'secondName': teacherData['teacher']!['second_name'] as String,
          if (teacherData['teacher']!['middle_name'] != null)
            'middleName': teacherData['teacher']!['middle_name'] as String,
        };

        late final Map<String, dynamic> group;
        if (task.groupId != null) {
          final groupResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/groups/${task.groupId}?access_token=$accessToken');

          final groupData =
              jsonDecode(groupResponse.data) as Map<String, dynamic>;

          group = <String, dynamic>{
            'id': groupData['Group']!['id'] as int,
            'name': groupData['Group']!['name'] as String,
          };
        }

        late final Map<String, dynamic> subgroup;
        if (task.subgroupId != null) {
          final subgroupResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/subgroups/${task.subgroupId}?access_token=$accessToken');

          final subgroupData =
              jsonDecode(subgroupResponse.data) as Map<String, dynamic>;

          subgroup = <String, dynamic>{
            'id': subgroupData['subgroup']!['id'] as int,
            'name': subgroupData['subgroup']!['name'] as String,
          };
        }

        late final Map<String, dynamic> student;

        if (task.studentId != null) {
          final studentResponse = await dio.Dio().get(
              'http://${scheduleServiceHost()}:${scheduleServicePort()}/students/${task.studentId}?access_token=$accessToken');

          final studentData =
              jsonDecode(studentResponse.data) as Map<String, dynamic>;

          student = <String, dynamic>{
            'user_id': studentData['student']!['user_id'] as int,
            'id': studentData['student']!['id'] as int,
            'firstName': studentData['student']!['firstName'] as String,
            'secondName': studentData['student']!['secondName'] as String,
            if (studentData['student']!['middleName'] != null)
              'middleName': studentData['student']!['middleName'] as String,
          };
        }

        tasks.add({
          'task_id': task.id,
          'subject': subject,
          'teacher': teacher,
          if (task.groupId != null) 'group': group,
          if (task.subgroupId != null) 'subgroup': subgroup,
          if (task.studentId != null) 'student': student,
          'content': task.content,
          'deadline_type': task.deadlineType.toString().split('.').last,
          'deadline': task.deadline?.toIso8601String(),
        });
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Task found',
        'tasks': tasks,
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
