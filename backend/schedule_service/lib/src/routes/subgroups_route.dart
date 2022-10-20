import 'package:schedule_service/schedule_service.dart';

class SubgroupsRoute {
  final SubgroupRepository subgroupRepository;
  final SubjectRepository subjectRepository;

  SubgroupsRoute(
      {required this.subgroupRepository, required this.subjectRepository});

  Handler get router {
    final router = Router();

    ///POST subgroup

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final name = params['name'];
      final role = req.context['role'];

      ////////// Проверяем параметры
      if (name == null) {
        return Response.badRequest(body: 'name is required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такая подгруппа

      if (await subgroupRepository.existsSubgroup(nameSubgroup: name)) {
        return Response.badRequest(body: 'Subgroup already exists.');
      }
      final Subgroup subgroup;
      ////////// Добавляем подгруппу
      try {
        subgroup = await subgroupRepository.insertSubgroup(name);
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subgroup added',
        'subgroup': {
          'id': subgroup.id,
          'name': subgroup.name,
        }
      }));
    });

    //Update subgroup

    router.post('/<id>', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final name = params['name'];
      final role = req.context['role'];

      ////////// Проверяем параметры
      if (name == null) {
        return Response.badRequest(body: 'name is required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такая подгруппа

      if (!await subgroupRepository.existsSubgroup(idSubgroup: int.parse(id))) {
        return Response.badRequest(body: 'Subgroup not exists.');
      }

      ////////// Обновляем подгруппу
      final Subgroup subgroup;
      try {
        subgroup = await subgroupRepository
            .updateSubgroup(Subgroup(id: int.parse(id), name: name));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subgroup updated',
        'subgroup': {
          'id': subgroup.id,
          'name': subgroup.name,
        }
      }));
    });

    ///GET subgroup

    router.get('/', (Request req) async {
      final subgroups = await subgroupRepository.getAllSubgroups();
      print(subgroups);
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subgroups',
        'subgroups': subgroups
            .map((e) => {
                  'id': e.id,
                  'name': e.name,
                })
            .toList()
      }));
    });

    ///GET subgroup/:id

    router.get('/<id>', (Request req, String id) async {
      if (!await subgroupRepository.existsSubgroup(idSubgroup: int.parse(id))) {
        return Response.badRequest(body: 'Subgroup not exists.');
      }

      final subgroup = await subgroupRepository.getSubgroup(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subgroup',
        'subgroup': {
          'id': subgroup.id,
          'name': subgroup.name,
        }
      }));
    });

    ///DELETE subgroup/:id

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await subgroupRepository.existsSubgroup(idSubgroup: int.parse(id))) {
        return Response.badRequest(body: 'Subgroup not exists.');
      }
      try {
        await subgroupRepository.deleteSubgroup(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subgroup deleted',
      }));
    });

    ///INSERT subgroup/:id/subject

    router.post('/<id>/subject', (Request req, String id) async {
      final params = req.url.queryParameters;
      final idSubject = params['subject_id'];
      final role = req.context['role'];

      if (idSubject == null) {
        return Response.badRequest(body: 'subject_id is required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (await subgroupRepository.existsSubgroupsSubject(
          int.parse(id), int.parse(idSubject))) {
        return Response.badRequest(body: 'Groups have .');
      }
      if (!await subjectRepository.existsSubject(
          idSubject: int.parse(idSubject))) {
        return Response.badRequest(body: 'Subject not exists.');
      }
      if (!await subgroupRepository.existsSubgroup(idSubgroup: int.parse(id))) {
        return Response.badRequest(body: 'Subgroup not exists.');
      }
      final Subject subject;
      try {
        subject = await subgroupRepository.addSubjectToSubgroup(
            int.parse(id), int.parse(idSubject));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject added',
        'subject': {
          'id': subject.id,
          'name': subject.name,
        }
      }));
    });

    ///DELETE subgroup/:id/subject

    router.delete('/<id>/subject', (Request req, String id) async {
      final params = req.url.queryParameters;
      final idSubject = params['subject_id'];
      final role = req.context['role'];

      if (idSubject == null) {
        return Response.badRequest(body: 'subject_id is required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await subgroupRepository.existsSubgroupsSubject(
          int.parse(id), int.parse(idSubject))) {
        return Response.badRequest(body: 'Group havn`t subject.');
      }
      if (!await subjectRepository.existsSubject(
          idSubject: int.parse(idSubject))) {
        return Response.badRequest(body: 'Subject not exists.');
      }
      if (!await subgroupRepository.existsSubgroup(idSubgroup: int.parse(id))) {
        return Response.badRequest(body: 'Subgroup not exists.');
      }

      try {
        await subgroupRepository.deleteSubjectFromSubgroup(
            int.parse(id), int.parse(idSubject));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject deleted',
      }));
    });

    ///GET subgroup/:id/subjects

    router.get('/<id>/subjects', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await subgroupRepository.existsSubgroup(idSubgroup: int.parse(id))) {
        return Response.badRequest(body: 'Subgroup not exists.');
      }
      final List<Subject> subjects;
      try {
        subjects =
            await subgroupRepository.getSubjectsBySubgroup(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject',
        'subject': subjects
            .map((e) => {
                  'id': e.id,
                  'name': e.name,
                })
            .toList()
      }));
    });
    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
