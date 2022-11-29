import 'package:schedule_service/schedule_service.dart';
import 'package:dio/dio.dart' as dio;

class StudentRoute {
  final StudentRepository studentRepository;
  final GroupRepository groupRepository;
  final SubgroupRepository subgroupRepository;

  StudentRoute(
      {required this.studentRepository,
      required this.groupRepository,
      required this.subgroupRepository});

  Handler get router {
    final router = Router();

    ///POST student

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final firstName = params['first_name'];
      final secondName = params['second_name'];
      final middleName = params['middle_name'];
      final groupId = params['group_id'];
      final subgroupId = params['subgroup_id'];
      final role = req.context['role'];
      final accessToken = req.context['access_token'];

      ////////// Проверяем параметры
      if (firstName == null) {
        return Response.badRequest(body: 'first_name is required');
      }
      if (secondName == null) {
        return Response.badRequest(body: 'second_name is required');
      }
      if (middleName == null) {
        return Response.badRequest(body: 'middle_name is required');
      }
      if (groupId == null) {
        return Response.badRequest(body: 'group_id is required');
      }
      if (subgroupId == null) {
        return Response.badRequest(body: 'subgroup_id is required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем наличие группы и подгруппы

      if (!await groupRepository.existsGroup(idGroup: int.parse(groupId))) {
        return Response.badRequest(body: 'Group not found');
      }

      if (!await subgroupRepository.existsSubgroup(
          idSubgroup: int.parse(subgroupId))) {
        return Response.badRequest(body: 'Subgroup not found');
      }

      ////////// Проверяем есть ли такой студент

      if (await studentRepository.existsStudent(
          firstName: firstName,
          secondName: secondName,
          middleName: middleName,
          idGroup: int.parse(groupId))) {
        return Response.badRequest(body: 'Student already exists.');
      }
      final dynamic user;
      try {
        user = await dio.Dio().post(
          'http://${authServiceHost()}:${authServicePort()}/users/?firstName=$firstName&secondName=$secondName&middleName=$middleName&role=student&accessToken=$accessToken',
        );
      } catch (e) {
        return Response.internalServerError(body: 'Error $e');
      }
      final userDecod = jsonDecode(user.data) as Map<String, dynamic>;

      final Student student;
      ////////// Добавляем студента
      try {
        student = await studentRepository.insertStudent(
            userDecod['id'],
            firstName,
            secondName,
            middleName,
            int.parse(groupId),
            int.parse(subgroupId));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'student added',
        'student': {
          'id': student.id,
          'user_id': student.userId,
          'firstName': student.firstName,
          'secondName': student.secondName,
          'middleName': student.middleName,
          'group_id': student.groupId,
          'subgroup_id': student.subgroupId,
          'register_code': userDecod['registerCode']
        }
      }));
    });

    ///GET student

    router.get('/<id>', (Request req, String id) async {
      final role = req.context['role'];
      final accessToken = req.context['access_token'];

      if (!await studentRepository.existsStudent(idStudent: int.parse(id))) {
        return Response.notFound('Student not found');
      }

      final JWT jwt;
      try {
        jwt = JWT.verify(accessToken as String, SecretKey(secretKey()),
            issuer: 'degree_auth');
      } catch (e) {
        return Response.unauthorized('Invalid access_token');
      }

      if (role == 'admin' || id == jwt.subject || role == 'teacher') {
        if (!await studentRepository.existsStudent(idStudent: int.parse(id))) {
          return Response.notFound('Student not found');
        }

        final Student student;
        try {
          student = await studentRepository.getStudent(int.parse(id));
        } catch (e) {
          return Response.internalServerError(body: e.toString());
        }

        final user = await dio.Dio().get(
            'http://${authServiceHost()}:${authServicePort()}/users/${student.userId}?access_token=$accessToken');
        final userDecod = jsonDecode(user.data) as Map<String, dynamic>;

        return Response.ok(jsonEncode({
          'status': 'success',
          'message': 'student found',
          'student': {
            'id': student.id,
            'user_id': student.userId,
            'firstName': student.firstName,
            'secondName': student.secondName,
            'middleName': student.middleName,
            'group_id': student.groupId,
            'subgroup_id': student.subgroupId,
            'register_code': userDecod['registerCode'],
          },
        }));
      } else {
        return Response.unauthorized("Haven't access");
      }
    });

    ///GET students

    router.get('/', (Request req) async {
      final role = req.context['role'];

      if (role == 'admin' || role == 'teacher') {
        final List<Student> students;
        try {
          students = await studentRepository.getAllStudents();
        } catch (e) {
          return Response.internalServerError(body: e.toString());
        }

        return Response.ok(jsonEncode({
          'status': 'success',
          'message': 'students found',
          'students': students
              .map((student) => {
                    'id': student.id,
                    'user_id': student.userId,
                    'firstName': student.firstName,
                    'secondName': student.secondName,
                    'middleName': student.middleName,
                    'group_id': student.groupId,
                    'subgroup_id': student.subgroupId,
                  })
              .toList(),
        }));
      } else {
        return Response.unauthorized("Haven't access");
      }
    });

    // Update student
    // TODO : доделать обновление профилья на стороне авторизации
    router.post('/<id>', (Request req, String id) async {
      final params = req.url.queryParameters;
      final firstName = params['first_name'];
      final secondName = params['second_name'];
      final middleName = params['middle_name'];
      final groupId = params['group_id'];
      final subgroupId = params['subgroup_id'];
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await studentRepository.existsStudent(idStudent: int.parse(id))) {
        return Response.notFound('Student not found');
      }
      final Student oldStudent;
      try {
        oldStudent = await studentRepository.getStudent(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      final Student student;
      try {
        student = await studentRepository.updateStudent(Student(
          id: int.parse(id),
          userId: oldStudent.userId,
          firstName: firstName ?? oldStudent.firstName,
          secondName: secondName ?? oldStudent.secondName,
          middleName: middleName ?? oldStudent.middleName,
          groupId: int.parse(groupId ?? oldStudent.groupId.toString()),
          subgroupId: int.parse(subgroupId ?? oldStudent.subgroupId.toString()),
        ));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'student updated',
        'student': {
          'id': student.id,
          'user_id': student.userId,
          'firstName': student.firstName,
          'secondName': student.secondName,
          'middleName': student.middleName,
          'group_id': student.groupId,
          'subgroup_id': student.subgroupId,
        }
      }));
    });

    // Delete student

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];
      final accessToken = req.context['access_token'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await studentRepository.existsStudent(idStudent: int.parse(id))) {
        return Response.notFound('Student not found');
      }

      final Student student;
      try {
        student = await studentRepository.getStudent(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      try {
        await dio.Dio().delete(
          'http://${authServiceHost()}:${authServicePort()}/users/${student.userId}?access_token=$accessToken',
        );
      } catch (e) {
        return Response.internalServerError(
            body: ' Not deleted user from auth_db $e');
      }

      try {
        await studentRepository.deleteStudent(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'student deleted',
      }));
    });

    // Get student by group

    router.get('/group/<id>', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await groupRepository.existsGroup(idGroup: int.parse(id))) {
        return Response.notFound('Group not found');
      }

      final List<Student> students;
      try {
        students = await studentRepository.getAllStudentsByGroup(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'students found',
        'students': students
            .map((student) => {
                  'id': student.id,
                  'user_id': student.userId,
                  'firstName': student.firstName,
                  'secondName': student.secondName,
                  'middleName': student.middleName,
                  'group_id': student.groupId,
                  'subgroup_id': student.subgroupId,
                })
            .toList(),
      }));
    });

    // Get student by subgroup

    router.get('/subgroup/<id>', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await subgroupRepository.existsSubgroup(idSubgroup: int.parse(id))) {
        return Response.notFound('Subgroup not found');
      }

      final List<Student> students;
      try {
        students =
            await studentRepository.getAllStudentsBySubgroup(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'students found',
        'students': students
            .map((student) => {
                  'id': student.id,
                  'user_id': student.userId,
                  'firstName': student.firstName,
                  'secondName': student.secondName,
                  'middleName': student.middleName,
                  'group_id': student.groupId,
                  'subgroup_id': student.subgroupId,
                })
            .toList(),
      }));
    });
    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
