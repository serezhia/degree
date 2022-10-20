import 'package:schedule_service/schedule_service.dart';

class GroupsRoute {
  final GroupRepository groupRepository;
  final SpecialityRepository specialityRepository;
  final SubjectRepository subjectRepository;
  GroupsRoute(
      {required this.specialityRepository,
      required this.groupRepository,
      required this.subjectRepository});

  Handler get router {
    final router = Router();

    // INSERT GROUP

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final idSpeciality = params['idSpeciality'];
      final name = params['name'];
      final course = params['course'];

      final role = req.context['role'];
      ////////// Проверяем параметры
      if (name == null || idSpeciality == null || course == null) {
        return Response.badRequest(
            body: 'name , idSpeciality and course is required.');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }
      ////////// Проверяем существование специальности

      if (!await specialityRepository.existsSpeciality(
          idSpeciality: int.parse(idSpeciality))) {
        return Response.badRequest(body: 'Speciality not found');
      }

      ////////// Проверяем есть ли такая группа

      if (await groupRepository.existsGroup(nameGroup: name)) {
        return Response.badRequest(body: 'Group already exists.');
      }
      final Group group;
      ////////// Добавляем группу
      try {
        group = await groupRepository.insertGroup(
            int.parse(idSpeciality), name, int.parse(course));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Group added',
        'Group': {
          'id': group.id,
          'idSpeciality': group.idSpeciality,
          'name': group.name,
          'course': group.course,
        }
      }));
    });

    // UPDATE GROUP

    router.post('/<id>', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final idSpeciality = params['idSpeciality'];
      final name = params['name'];
      final course = params['course'];

      final role = req.context['role'];
      ////////// Проверяем параметры
      if (name == null || idSpeciality == null || course == null) {
        return Response.badRequest(
            body: 'name , idSpeciality and course is required.');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такая группа

      if (!await groupRepository.existsGroup(idGroup: int.parse(id))) {
        return Response.badRequest(body: 'Group not exists.');
      }
      final Group group;
      ////////// Добавляем группу
      try {
        group = await groupRepository.updateGroup(Group(
            id: int.parse(id),
            idSpeciality: int.parse(idSpeciality),
            name: name,
            course: int.parse(id)));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Group updated',
        'Group': {
          'id': group.id,
          'idSpeciality': group.idSpeciality,
          'name': group.name,
          'course': group.course,
        }
      }));
    });

    // GET GROUP BY ID

    router.get('/<id>', (Request req, String id) async {
      ////////// Проверяем есть ли такая группа

      if (!(await groupRepository.existsGroup(idGroup: int.parse(id)))) {
        return Response.badRequest(body: 'Group not found.');
      }
      ////////// Получаем группу
      final group = await groupRepository.getGroup(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Group found',
        'Group': {
          'id': group.id,
          'idSpeciality': group.idSpeciality,
          'name': group.name,
          'course': group.course,
        }
      }));
    });

    // GET ALL GROUPS

    router.get('/', (Request req) async {
      ////////// Получаем все группы
      final groups = await groupRepository.getAllGroups();

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Groups found',
        'Groups': groups
            .map((group) => {
                  'id': group.id,
                  'idSpeciality': group.idSpeciality,
                  'name': group.name,
                  'course': group.course,
                })
            .toList()
      }));
    });

    // DELETE GROUP

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];
      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такая группа

      if (!(await groupRepository.existsGroup(idGroup: int.parse(id)))) {
        return Response.badRequest(body: 'Group not found.');
      }
      ////////// Удаляем группу
      await groupRepository.deleteGroup(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Group deleted',
      }));
    });

    // INSERT subject in group

    router.post('/<id>/subject', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final idSubject = params['subject_id'];

      final role = req.context['role'];
      ////////// Проверяем параметры
      if (idSubject == null) {
        return Response.badRequest(body: 'idSubject is required.');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такая группа

      if (!(await groupRepository.existsGroup(idGroup: int.parse(id)))) {
        return Response.badRequest(body: 'Group not found.');
      }

      ////////// Проверяем есть ли такой предмет

      if (!(await subjectRepository.existsSubject(
          idSubject: int.parse(idSubject)))) {
        return Response.badRequest(body: 'Subject not found.');
      }

      ////////// Проверяем есть ли такая связь

      if (await groupRepository.existsGroupsSubject(
          int.parse(id), int.parse(idSubject))) {
        return Response.badRequest(body: 'Subject already exists in group.');
      }

      final Subject subject;
      ////////// Добавляем связь
      try {
        subject = await groupRepository.addSubjectToGroup(
            int.parse(id), int.parse(idSubject));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Subject added in group',
        'Subject': {
          'id': subject.id,
          'name': subject.name,
        }
      }));
    });

    // GET ALL subjects in group

    router.get('/<id>/subject', (Request req, String id) async {
      ////////// Проверяем есть ли такая группа

      if (!(await groupRepository.existsGroup(idGroup: int.parse(id)))) {
        return Response.badRequest(body: 'Group not found.');
      }

      ////////// Получаем все предметы
      final subjects = await groupRepository.getSubjectsByGroup(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Subjects found',
        'Subjects': subjects
            .map((subject) => {
                  'id': subject.id,
                  'name': subject.name,
                })
            .toList()
      }));
    });

    // DELETE subject in group

    router.delete('/<id>/subject', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final idSubject = params['subject_id'];
      final role = req.context['role'];
      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }
      if (idSubject == null) {
        return Response.badRequest(body: 'idSubject is required.');
      }

      ////////// Проверяем есть ли такая группа

      if (!(await groupRepository.existsGroup(idGroup: int.parse(id)))) {
        return Response.badRequest(body: 'Group not found.');
      }

      ////////// Проверяем есть ли такой предмет

      if (!(await subjectRepository.existsSubject(
          idSubject: int.parse(idSubject)))) {
        return Response.badRequest(body: 'Subject not found.');
      }

      ////////// Проверяем есть ли такая связь

      if (!(await groupRepository.existsGroupsSubject(
          int.parse(id), int.parse(idSubject)))) {
        return Response.badRequest(body: 'Subject not found in group.');
      }

      ////////// Удаляем связь
      await groupRepository.deleteSubjectFromGroup(
          int.parse(id), int.parse(idSubject));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Subject deleted from group',
      }));
    });
    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
