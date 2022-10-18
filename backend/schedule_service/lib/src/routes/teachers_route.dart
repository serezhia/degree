import 'package:schedule_service/schedule_service.dart';
import 'package:schedule_service/src/models/teacher_model.dart';
import 'package:schedule_service/src/repository/teacher_repository.dart';

class TeachersRoute {
  final TeacherRepository teacherRepository;
  final SubjectRepository subjectRepository;

  TeachersRoute(
      {required this.teacherRepository, required this.subjectRepository});

  Handler get router {
    final router = Router();

    /// INSERT teacher

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final firstName = params['first_name'];
      final secondName = params['second_name'];
      final middleName = params['middle_name'];

      if (firstName == null || secondName == null) {
        return Response.badRequest(
            body: 'first_name, second_name, {middle_name} is required.');
      }
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой преподаватель

      if (await teacherRepository.existsTeacher(
        firstName: firstName,
        secondName: secondName,
        middleName: middleName,
      )) {
        return Response.badRequest(body: 'Teacher already exists.');
      }

      ////////// Добавляем преподавателя
      final teacher = await teacherRepository.insertTeacher(
          firstName, secondName, middleName, 0);

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'teacher added',
        'teacher': {
          'id': '${teacher.id}',
          'first_name': firstName,
          'second_name': secondName,
          'middle_name': middleName,
        }
      }));
    });

    /// UPDATE teacher

    router.post('/<id>', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final firstName = params['first_name'];
      final secondName = params['second_name'];
      final middleName = params['middle_name'];

      if (firstName == null || secondName == null) {
        return Response.badRequest(
            body: 'first_name, second_name, {middle_name} is required.');
      }
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой преподаватель

      if (!await teacherRepository.existsTeacher(idTeacher: int.parse(id))) {
        return Response.badRequest(body: 'Teacher not exists.');
      }

      final oldTeacher = await teacherRepository.getTeacher(int.parse(id));

      final updateTeacher = Teacher(
        id: int.parse(id),
        userId: oldTeacher.userId,
        firstName: firstName,
        secondName: secondName,
        middleName: middleName,
      );
      ////////// Обновляем преподавателя
      final teacher = await teacherRepository.updateTeacher(updateTeacher);

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'teacher updated',
        'teacher': {
          'id': '${teacher.id}',
          'first_name': firstName,
          'second_name': secondName,
          'middle_name': middleName,
        }
      }));
    });

    /// GET teacher

    router.get('/<id>', (Request req, String id) async {
      if (!await teacherRepository.existsTeacher(idTeacher: int.parse(id))) {
        return Response.ok(jsonEncode({
          'status': 'error',
          'message': 'teacher exists',
          'teacher': {
            'id': id,
          }
        }));
      }

      final teacher = await teacherRepository.getTeacher(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'teacher getted',
        'teacher': {
          'id': '${teacher.id}',
          'first_name': teacher.firstName,
          'second_name': teacher.secondName,
          'middle_name': teacher.middleName,
        }
      }));
    });

    /// GET teachers

    router.get('/', (Request req) async {
      final teachers = await teacherRepository.getAllTeachers();

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'teachers getted',
        'teachers': teachers
            .map((teacher) => {
                  'id': '${teacher.id}',
                  'first_name': teacher.firstName,
                  'second_name': teacher.secondName,
                  'middle_name': teacher.middleName,
                  'subjects': teacher.subjects
                      ?.map((subject) => {
                            'id': '${subject.id}',
                            'name': subject.name,
                          })
                      .toList(),
                })
            .toList()
      }));
    });

    /// DELETE teacher

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await teacherRepository.existsTeacher(idTeacher: int.parse(id))) {
        return Response.badRequest(body: 'Teacher not exists.');
      }

      await teacherRepository.deleteTeacher(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'teacher deleted',
      }));
    });

    /// INSERT subject to teacher
    router.post('/<id>/subject', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await teacherRepository.existsTeacher(idTeacher: int.parse(id))) {
        return Response.badRequest(body: 'Teacher not exists.');
      }

      final params = req.url.queryParameters;
      final subjectIdString = params['subject_id'];

      final teacherId = int.parse(id);

      if (subjectIdString == null) {
        return Response.badRequest(body: 'subject_id is required.');
      }

      final subjectId = int.parse(subjectIdString);

      if (!await subjectRepository.existsSubject(idSubject: subjectId)) {
        return Response.badRequest(body: 'Subject not exists.');
      }

      if (await teacherRepository.existsTeachersSubject(teacherId, subjectId)) {
        return Response.badRequest(body: 'Teacher already has this subject.');
      }
      final Subject subject;
      try {
        subject =
            await teacherRepository.addSubjectToTeacher(teacherId, subjectId);
      } catch (e) {
        return Response.badRequest(body: '$e');
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject added to teacher',
        'subject': {
          'id': '${subject.id}',
          'name': subject.name,
        }
      }));
    });

    /// DELETE subject from teacher

    router.delete('/<id>/subject', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await teacherRepository.existsTeacher(idTeacher: int.parse(id))) {
        return Response.badRequest(body: 'Teacher not exists.');
      }

      final params = req.url.queryParameters;
      final subjectIdString = params['subject_id'];

      final teacherId = int.parse(id);

      if (subjectIdString == null) {
        return Response.badRequest(body: 'subject_id is required.');
      }

      final subjectId = int.parse(subjectIdString);

      if (!await subjectRepository.existsSubject(idSubject: subjectId)) {
        return Response.badRequest(body: 'Subject not exists.');
      }

      if (!await teacherRepository.existsTeachersSubject(
          teacherId, subjectId)) {
        return Response.badRequest(body: 'Teacher has not this subject.');
      }

      try {
        await teacherRepository.deleteSubjectFromTeacher(teacherId, subjectId);
      } catch (e) {
        return Response.badRequest(body: '$e');
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject deleted from teacher',
      }));
    });

    /// GET subjects of teacher

    router.get('/<id>/subjects', (Request req, String id) async {
      if (!await teacherRepository.existsTeacher(idTeacher: int.parse(id))) {
        return Response.badRequest(body: 'Teacher not exists.');
      }

      final teacherId = int.parse(id);

      final subjects = await teacherRepository.getSubjectsByTeacher(teacherId);

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subjects getted',
        'subjects': subjects
            .map((subject) => {
                  'id': '${subject.id}',
                  'name': subject.name,
                })
            .toList()
      }));
    });

    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
