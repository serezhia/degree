import 'package:schedule_service/schedule_service.dart';

class SubjectsRoute {
  final SubjectRepository repository;
  SubjectsRoute({required this.repository});

  Handler get router {
    final router = Router();

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final name = params['name'];
      final role = req.context['role'];
      ////////// Проверяем параметры
      if (name == null) {
        return Response.badRequest(body: 'Name subject is required.');
      }
      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой предмет

      if (await repository.existsSubject(nameSubject: name)) {
        return Response.badRequest(body: 'Subject already exists.');
      }
      final Subject subject;
      ////////// Добавляем предмет
      try {
        subject = await repository.insertSubject(name);
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject added',
        'subject': {
          'id': '${subject.id}',
          'name': name,
        }
      }));
    });

    ///GET subject By id

    router.get('/<id>', (Request req, String id) async {
      ////////// Проверяем есть ли такой предмет

      if (!(await repository.existsSubject(idSubject: int.parse(id)))) {
        return Response.badRequest(body: 'subject not found.');
      }
      ////////// Получаем предмет
      final subject = await repository.getSubject(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject found',
        'subject': {
          'id': '${subject.id}',
          'name': subject.name,
        }
      }));
    });

    ///GET all subjects

    router.get('/', (Request req) async {
      final subjects = await repository.getAllSubjects();
      if (subjects.isEmpty) {
        return Response.ok(jsonEncode({
          'status': 'success',
          'message': 'subjects not found',
          'subjects': [],
        }));
      }
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subjects found',
        'subjects': subjects
            .map((e) => {
                  'id': '${e.id}',
                  'name': e.name,
                })
            .toList(),
      }));
    });

    ///DELETE subject By id

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];
      ////////// Проверяем параметры
      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой предмет
      if (!(await repository.existsSubject(idSubject: int.parse(id)))) {
        return Response.badRequest(body: 'subject not found.');
      }

      ////////// Удаляем предмет
      try {
        await repository.deleteSubject(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
      return Response.ok('Delete subject');
    });

    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
