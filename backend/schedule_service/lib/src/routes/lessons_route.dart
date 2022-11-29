import 'dart:developer';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:schedule_service/schedule_service.dart';

class LessonsRoute {
  final LessonRepository lessonRepository;
  final SubgroupRepository subgroupRepository;
  final GroupRepository groupRepository;
  final TeacherRepository teacherRepository;
  final CabinetRepository cabinetRepository;
  final SubjectRepository subjectRepository;
  final StudentRepository studentRepository;

  LessonsRoute({
    required this.lessonRepository,
    required this.subgroupRepository,
    required this.groupRepository,
    required this.teacherRepository,
    required this.cabinetRepository,
    required this.subjectRepository,
    required this.studentRepository,
  });

  Handler get router {
    final router = Router();

    router.post('/type', (Request req) async {
      final params = req.url.queryParameters;
      final name = params['name'];
      final role = req.context['role'];
      if (name == null) {
        return Response.badRequest(body: 'name is required');
      }
      if (role != 'admin') {
        return Response.forbidden('only admin can create lesson');
      }

      if (await lessonRepository.existsLessonType(name: name)) {
        return Response.badRequest(body: 'Lesson type already exists');
      }
      final lessonType = await lessonRepository.insertLessonType(name);
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'lesson type created',
        'lesson': {
          'id': lessonType.id,
          'name': lessonType.name,
        },
      }));
    });

    router.post('/type/<id>', (Request req, String id) async {
      final role = req.context['role'];
      final params = req.url.queryParameters;
      final name = params['name'];

      if (role != 'admin') {
        return Response.forbidden('only admin can create lesson');
      }
      if (name == null) {
        return Response.badRequest(body: 'name is required');
      }

      if (!await lessonRepository.existsLessonType(
          lessonTypeId: int.parse(id))) {
        return Response.badRequest(body: 'Lesson type not found');
      }

      final lessonType = await lessonRepository
          .updateLessonType(LessonType(id: int.parse(id), name: name));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'lesson type updated',
        'lessonType': {
          'id': lessonType.id,
          'name': lessonType.name,
        },
      }));
    });

    router.delete('/type/<id>', (Request req, String id) async {
      final role = req.context['role'];
      if (role != 'admin') {
        return Response.forbidden('only admin can create lesson');
      }

      if (!await lessonRepository.existsLessonType(
          lessonTypeId: int.parse(id))) {
        return Response.notFound('lesson type not found');
      }

      await lessonRepository.deleteLessonType(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'lesson type deleted',
      }));
    });

    router.get('/type', (Request req) async {
      final lessonTypes = await lessonRepository.getAllLessonTypes();
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'lesson types fetched',
        'lessonTypes': lessonTypes
            .map((e) => {
                  'id': e.id,
                  'name': e.name,
                })
            .toList(),
      }));
    });

    router.get('/type/<id>', (Request req, String id) async {
      final LessonType lessonType;

      try {
        lessonType = await lessonRepository.getLessonType(int.parse(id));
      } catch (e) {
        return Response.notFound('lesson type not found');
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'lesson type fetched',
        'lessonType': {
          'id': lessonType.id,
          'name': lessonType.name,
        },
      }));
    });

    router.post('/<id>', (Request req, String id) async {
      final params = req.url.queryParameters;
      final role = req.context['role'];
      final groupIdString = params['group_id'];
      final subgroupIdString = params['subgroup_id'];
      final subjectIdString = params['subject_id'];
      final teacherIdString = params['teacher_id'];
      final cabinetIdString = params['cabinet_id'];
      final lessonTypeIdString = params['lessonType_id'];
      final lessonNumberString = params['lessonNumber'];
      final dayString = params['day'];

      if (role != 'admin') {
        return Response.forbidden('only admin can create lesson');
      }
      if (subjectIdString == null) {
        return Response.badRequest(body: 'subject_id is required');
      }
      if (teacherIdString == null) {
        return Response.badRequest(body: 'teacher_id is required');
      }
      if (cabinetIdString == null) {
        return Response.badRequest(body: 'cabinet_id is required');
      }
      if (lessonTypeIdString == null) {
        return Response.badRequest(body: 'lesson_type_id is required');
      }
      if (lessonNumberString == null) {
        return Response.badRequest(body: 'lesson_number is required');
      }
      if (dayString == null) {
        return Response.badRequest(body: 'day is required');
      }
      final subgroupId =
          subgroupIdString == null ? null : int.parse(subgroupIdString);
      final groupId = groupIdString == null ? null : int.parse(groupIdString);
      final subjectId = int.parse(subjectIdString);
      final teacherId = int.parse(teacherIdString);
      final cabinetId = int.parse(cabinetIdString);
      final lessonTypeId = int.parse(lessonTypeIdString);
      final lessonNumber = int.parse(lessonNumberString);
      final day = DateTime.parse(dayString);

      if (!await subjectRepository.existsSubject(idSubject: subjectId)) {
        return Response.badRequest(body: 'Subject not found');
      }
      if (!await teacherRepository.existsTeacher(idTeacher: teacherId)) {
        return Response.badRequest(body: 'Teacher not found');
      }

      if (!await cabinetRepository.existsCabinet(idCabinet: cabinetId)) {
        return Response.badRequest(body: 'Cabinet not found');
      }

      if (!await lessonRepository.existsLessonType(
          lessonTypeId: lessonTypeId)) {
        return Response.badRequest(body: 'LessonType not found');
      }

      if (groupId != null &&
          !await groupRepository.existsGroup(idGroup: groupId)) {
        return Response.badRequest(body: 'Group not found');
      }

      if (subgroupId != null &&
          !await subgroupRepository.existsSubgroup(idSubgroup: subgroupId)) {
        return Response.badRequest(body: 'Subgroup not found');
      }
      if (!await lessonRepository.existsLesson(lessonId: int.parse(id))) {
        return Response.badRequest(body: 'Lesson not found');
      }
      Lesson lessonData;

      try {
        if (groupId != null) {
          lessonData = await lessonRepository.updateLesson(Lesson(
              lessonId: int.parse(id),
              groupId: groupId,
              subjectId: subjectId,
              teacherId: teacherId,
              cabinetId: cabinetId,
              lessonTypeId: lessonTypeId,
              lessonNumber: lessonNumber,
              day: day));
        } else {
          lessonData = await lessonRepository.updateLesson(Lesson(
              lessonId: int.parse(id),
              subgroupId: subgroupId,
              subjectId: subjectId,
              teacherId: teacherId,
              cabinetId: cabinetId,
              lessonTypeId: lessonTypeId,
              lessonNumber: lessonNumber,
              day: day));
        }
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
      final data = await lessonRepository.getLesson(lessonData.lessonId);
      final lesson = {
        'lesson_id': data.lessonId,
        if (data.groupId != null)
          'group': {
            'id': data.groupId,
            'name': (await groupRepository.getGroup(data.groupId!)).name,
          },
        if (data.subgroupId != null)
          'subgroup': {
            'id': data.subgroupId,
            'name':
                (await subgroupRepository.getSubgroup(data.subgroupId!)).name,
          },
        'subject': {
          'id': data.subjectId,
          'name': (await subjectRepository.getSubject(data.subjectId)).name,
        },
        'teacher': {
          'userId': (await teacherRepository.getTeacher(data.teacherId)).userId,
          'teacherId': data.teacherId,
          'firstName':
              (await teacherRepository.getTeacher(data.teacherId)).firstName,
          'secondName':
              (await teacherRepository.getTeacher(data.teacherId)).secondName,
          if ((await teacherRepository.getTeacher(data.teacherId)).middleName !=
              null)
            'middleName':
                (await teacherRepository.getTeacher(data.teacherId)).middleName,
        },
        'cabinet': {
          'id': data.cabinetId,
          'number': (await cabinetRepository.getCabinet(data.cabinetId)).number,
        },
        'lessonType': {
          'id': data.lessonTypeId,
          'name':
              (await lessonRepository.getLessonType(data.lessonTypeId)).name,
        },
        'lessonNumber': data.lessonNumber,
        'day': data.day.toIso8601String(),
      };
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'lesson updated',
        'lesson': lesson
      }));
    });

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final role = req.context['role'];
      final groupIdString = params['group_id'];
      final subgroupIdString = params['subgroup_id'];
      final subjectIdString = params['subject_id'];
      final teacherIdString = params['teacher_id'];
      final cabinetIdString = params['cabinet_id'];
      final lessonTypeIdString = params['lessonType_id'];
      final lessonNumberString = params['lessonNumber'];
      final dayString = params['day'];

      ////////// Проверяем параметры

      // Проверяем, что все параметры переданы
      if (subjectIdString == null ||
          teacherIdString == null ||
          cabinetIdString == null ||
          lessonTypeIdString == null ||
          lessonNumberString == null ||
          dayString == null) {
        return Response.badRequest(
            body:
                ('subject_id , teacher_id , cabinet_id , lessonType_id , lessonNumber , day is required'));
      }
      if (groupIdString == null && subgroupIdString == null) {
        return Response.badRequest(
            body: ('group_id or subgroup_id is required'));
      }

      final subgroupId =
          subgroupIdString == null ? null : int.parse(subgroupIdString);
      final groupId = groupIdString == null ? null : int.parse(groupIdString);
      final subjectId = int.parse(subjectIdString);
      final teacherId = int.parse(teacherIdString);
      final cabinetId = int.parse(cabinetIdString);
      final lessonTypeId = int.parse(lessonTypeIdString);
      final lessonNumber = int.parse(lessonNumberString);
      final day = DateTime.parse(dayString);

      ////////// Проверяем права

      if (role != 'admin') {
        return Response.forbidden('You have no rights to add lessons');
      }

      if ((groupIdString != null) & (subgroupIdString != null)) {
        return Response.badRequest(
            body: 'only group_id or subject_id is required');
      }

      ////////// Проверяем наличие занятия

      if (await lessonRepository.existsLesson(
          subgroupId: subgroupId,
          groupId: groupId,
          subjectId: subjectId,
          teacherId: teacherId,
          cabinetId: cabinetId,
          lessonTypeId: lessonTypeId,
          lessonNumber: lessonNumber,
          day: day)) {
        return Response.badRequest(body: 'Lesson already exists');
      }

      if (!await subjectRepository.existsSubject(idSubject: subjectId)) {
        return Response.badRequest(body: 'Subject not found');
      }
      if (!await teacherRepository.existsTeacher(idTeacher: teacherId)) {
        return Response.badRequest(body: 'Teacher not found');
      }

      if (!await cabinetRepository.existsCabinet(idCabinet: cabinetId)) {
        return Response.badRequest(body: 'Cabinet not found');
      }

      if (!await lessonRepository.existsLessonType(
          lessonTypeId: lessonTypeId)) {
        return Response.badRequest(body: 'LessonType not found');
      }

      if (groupId != null &&
          !await groupRepository.existsGroup(idGroup: groupId)) {
        return Response.badRequest(body: 'Group not found');
      }

      if (subgroupId != null &&
          !await subgroupRepository.existsSubgroup(idSubgroup: subgroupId)) {
        return Response.badRequest(body: 'Subgroup not found');
      }

      Lesson lesson;
      try {
        if (groupId != null) {
          lesson = await lessonRepository.insertLesson(
              groupId: groupId,
              subjectId: subjectId,
              teacherId: teacherId,
              cabinetId: cabinetId,
              lessonTypeId: lessonTypeId,
              lessonNumber: lessonNumber,
              day: day);
        } else {
          lesson = await lessonRepository.insertLesson(
              subgroupId: subgroupId,
              subjectId: subjectId,
              teacherId: teacherId,
              cabinetId: cabinetId,
              lessonTypeId: lessonTypeId,
              lessonNumber: lessonNumber,
              day: day);
        }
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lesson': {
          'lesson_id': lesson.lessonId,
          'group_id': lesson.groupId,
          'subgroup_id': lesson.subgroupId,
          'subject_id': lesson.subjectId,
          'teacher_id': lesson.teacherId,
          'cabinet_id': lesson.cabinetId,
          'lessonType_id': lesson.lessonTypeId,
          'lessonNumber': lesson.lessonNumber,
          'day': lesson.day.toIso8601String(),
        }
      }));
    });

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];
      if (role != 'admin') {
        return Response.forbidden('You have no rights to delete lessons');
      }
      if (!await lessonRepository.existsLesson(lessonId: int.parse(id))) {
        return Response.badRequest(body: 'Lesson not found');
      }
      lessonRepository.deleteLesson(int.parse(id));
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'lesson deleted',
      }));
    });

    router.get('/', (Request req) async {
      final lessons = await lessonRepository.getAllLessons();
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lessons': lessons
            .map((e) => {
                  'lesson_id': e.lessonId,
                  'group_id': e.groupId,
                  'subgroup_id': e.subgroupId,
                  'subject_id': e.subjectId,
                  'teacher_id': e.teacherId,
                  'cabinet_id': e.cabinetId,
                  'lessonType_id': e.lessonTypeId,
                  'lessonNumber': e.lessonNumber,
                  'day': e.day.toIso8601String(),
                })
            .toList()
      }));
    });

    router.get('/student/<id>', (Request req, String id) async {
      final studentId = int.parse(id);

      if (!await studentRepository.existsStudent(idStudent: studentId)) {
        return Response.badRequest(body: 'Student not found');
      }

      final lessons = await lessonRepository.getLessonsByStudent(studentId);
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lessons': lessons
            .map(
              (e) => {
                'lesson_id': e.lessonId,
                'group_id': e.groupId,
                'subgroup_id': e.subgroupId,
                'subject_id': e.subjectId,
                'teacher_id': e.teacherId,
                'cabinet_id': e.cabinetId,
                'lessonType_id': e.lessonTypeId,
                'lessonNumber': e.lessonNumber,
                'day': e.day.toIso8601String(),
              },
            )
            .toList(),
      }));
    });

    router.get('/teacher/<id>', (Request req, String id) async {
      final teacherId = int.parse(id);

      if (!await teacherRepository.existsTeacher(idTeacher: teacherId)) {
        return Response.badRequest(body: 'Teacher not found');
      }

      final lessons = await lessonRepository.getLessonsByTeacher(teacherId);
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lessons': lessons
            .map(
              (e) => {
                'lesson_id': e.lessonId,
                'group_id': e.groupId,
                'subgroup_id': e.subgroupId,
                'subject_id': e.subjectId,
                'teacher_id': e.teacherId,
                'cabinet_id': e.cabinetId,
                'lessonType_id': e.lessonTypeId,
                'lessonNumber': e.lessonNumber,
                'day': e.day.toIso8601String(),
              },
            )
            .toList(),
      }));
    });

    router.get('/group/<id>', (Request req, String id) async {
      final groupId = int.parse(id);

      if (!await groupRepository.existsGroup(idGroup: groupId)) {
        return Response.badRequest(body: 'Group not found');
      }

      final lessons = await lessonRepository.getLessonsByGroup(groupId);
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lessons': lessons
            .map(
              (e) => {
                'lesson_id': e.lessonId,
                'group_id': e.groupId,
                'subgroup_id': e.subgroupId,
                'subject_id': e.subjectId,
                'teacher_id': e.teacherId,
                'cabinet_id': e.cabinetId,
                'lessonType_id': e.lessonTypeId,
                'lessonNumber': e.lessonNumber,
                'day': e.day.toIso8601String(),
              },
            )
            .toList(),
      }));
    });

    router.get('/subgroup/<id>', (Request req, String id) async {
      final subgroupId = int.parse(id);

      if (!await subgroupRepository.existsSubgroup(idSubgroup: subgroupId)) {
        return Response.badRequest(body: 'Subgroup not found');
      }

      final lessons = await lessonRepository.getLessonsBySubgroup(subgroupId);
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lessons': lessons
            .map(
              (e) => {
                'lesson_id': e.lessonId,
                'group_id': e.groupId,
                'subgroup_id': e.subgroupId,
                'subject_id': e.subjectId,
                'teacher_id': e.teacherId,
                'cabinet_id': e.cabinetId,
                'lessonType_id': e.lessonTypeId,
                'lessonNumber': e.lessonNumber,
                'day': e.day.toIso8601String(),
              },
            )
            .toList(),
      }));
    });

    router.get('/<id>', (Request req, String id) async {
      final lessonId = int.parse(id);
      if (!await lessonRepository.existsLesson(lessonId: int.parse(id))) {
        return Response.badRequest(body: 'Lesson not found');
      }

      final data = await lessonRepository.getLesson(lessonId);
      final lesson = {
        'lesson_id': data.lessonId,
        if (data.groupId != null)
          'group': {
            'id': data.groupId,
            'name': (await groupRepository.getGroup(data.groupId!)).name,
          },
        if (data.subgroupId != null)
          'subgroup': {
            'id': data.subgroupId,
            'name':
                (await subgroupRepository.getSubgroup(data.subgroupId!)).name,
          },
        'subject': {
          'id': data.subjectId,
          'name': (await subjectRepository.getSubject(data.subjectId)).name,
        },
        'teacher': {
          'userId': (await teacherRepository.getTeacher(data.teacherId)).userId,
          'teacherId': data.teacherId,
          'firstName':
              (await teacherRepository.getTeacher(data.teacherId)).firstName,
          'secondName':
              (await teacherRepository.getTeacher(data.teacherId)).secondName,
          if ((await teacherRepository.getTeacher(data.teacherId)).middleName !=
              null)
            'middleName':
                (await teacherRepository.getTeacher(data.teacherId)).middleName,
        },
        'cabinet': {
          'id': data.cabinetId,
          'number': (await cabinetRepository.getCabinet(data.cabinetId)).number,
        },
        'lessonType': {
          'id': data.lessonTypeId,
          'name':
              (await lessonRepository.getLessonType(data.lessonTypeId)).name,
        },
        'lessonNumber': data.lessonNumber,
        'day': data.day.toIso8601String(),
      };
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lesson': lesson,
      }));
    });
    router.get('/day/<day>', (Request req, String day) async {
      final role = req.context['role'];
      final accessToken = req.context['access_token'] as String;
      final userId = JwtDecoder.decode(accessToken)['sub'] as String;

      final data = await lessonRepository.getLessonsByDay(DateTime.parse(day));
      var lessons = <Map<String, Object>>[];
      if (role == 'teacher') {
        final teacher =
            await teacherRepository.getTeacherByUserId(int.parse(userId));
        for (var e in data) {
          if (e.teacherId == teacher.id) {
            final lesson = {
              'lesson_id': e.lessonId,
              if (e.groupId != null)
                'group': {
                  'id': e.groupId,
                  'name': (await groupRepository.getGroup(e.groupId!)).name,
                },
              if (e.subgroupId != null)
                'subgroup': {
                  'id': e.subgroupId,
                  'name': (await subgroupRepository.getSubgroup(e.subgroupId!))
                      .name,
                },
              'subject': {
                'id': e.subjectId,
                'name': (await subjectRepository.getSubject(e.subjectId)).name,
              },
              'teacher': {
                'userId':
                    (await teacherRepository.getTeacher(e.teacherId)).userId,
                'teacherId': e.teacherId,
                'firstName':
                    (await teacherRepository.getTeacher(e.teacherId)).firstName,
                'secondName': (await teacherRepository.getTeacher(e.teacherId))
                    .secondName,
                if ((await teacherRepository.getTeacher(e.teacherId))
                        .middleName !=
                    null)
                  'middleName':
                      (await teacherRepository.getTeacher(e.teacherId))
                          .middleName,
              },
              'cabinet': {
                'id': e.cabinetId,
                'number':
                    (await cabinetRepository.getCabinet(e.cabinetId)).number,
              },
              'lessonType': {
                'id': e.lessonTypeId,
                'name':
                    (await lessonRepository.getLessonType(e.lessonTypeId)).name,
              },
              'lessonNumber': e.lessonNumber,
              'day': e.day.toIso8601String(),
            };
            lessons.add(lesson);
          }
        }
      } else {
        for (var e in data) {
          final lesson = {
            'lesson_id': e.lessonId,
            if (e.groupId != null)
              'group': {
                'id': e.groupId,
                'name': (await groupRepository.getGroup(e.groupId!)).name,
              },
            if (e.subgroupId != null)
              'subgroup': {
                'id': e.subgroupId,
                'name':
                    (await subgroupRepository.getSubgroup(e.subgroupId!)).name,
              },
            'subject': {
              'id': e.subjectId,
              'name': (await subjectRepository.getSubject(e.subjectId)).name,
            },
            'teacher': {
              'userId':
                  (await teacherRepository.getTeacher(e.teacherId)).userId,
              'teacherId': e.teacherId,
              'firstName':
                  (await teacherRepository.getTeacher(e.teacherId)).firstName,
              'secondName':
                  (await teacherRepository.getTeacher(e.teacherId)).secondName,
              if ((await teacherRepository.getTeacher(e.teacherId))
                      .middleName !=
                  null)
                'middleName': (await teacherRepository.getTeacher(e.teacherId))
                    .middleName,
            },
            'cabinet': {
              'id': e.cabinetId,
              'number':
                  (await cabinetRepository.getCabinet(e.cabinetId)).number,
            },
            'lessonType': {
              'id': e.lessonTypeId,
              'name':
                  (await lessonRepository.getLessonType(e.lessonTypeId)).name,
            },
            'lessonNumber': e.lessonNumber,
            'day': e.day.toIso8601String(),
          };
          lessons.add(lesson);
        }
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': '',
        'lessons': lessons,
      }));
    });

    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
