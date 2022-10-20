import 'package:schedule_service/schedule_service.dart';

class SpecialitysRoute {
  final SpecialityRepository repository;
  SpecialitysRoute({required this.repository});

  Handler get router {
    final router = Router();

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final name = params['name'];
      final role = req.context['role'];
      ////////// Проверяем параметры
      if (name == null) {
        return Response.badRequest(body: 'name is required.');
      }
      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой предмет

      if (await repository.existsSpeciality(nameSpeciality: name)) {
        return Response.badRequest(body: 'Speciality already exists.');
      }
      final Speciality speciality;
      ////////// Добавляем предмет
      try {
        speciality = await repository.insertSpeciality(name);
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Speciality added',
        'Speciality': {
          'id': speciality.id,
          'name': name,
        }
      }));
    });

    ///GET Speciality By id

    router.get('/<id>', (Request req, String id) async {
      ////////// Проверяем есть ли такой предмет

      if (!(await repository.existsSpeciality(idSpeciality: int.parse(id)))) {
        return Response.badRequest(body: 'Speciality not found.');
      }
      ////////// Получаем предмет
      final speciality = await repository.getSpeciality(int.parse(id));

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'Speciality found',
        'Speciality': {
          'id': speciality.id,
          'name': speciality.name,
        }
      }));
    });

    ///GET all Specialitys

    router.get('/', (Request req) async {
      final specialitys = await repository.getAllSpecialitys();
      if (specialitys.isEmpty) {
        return Response.ok(jsonEncode({
          'status': 'success',
          'message': 'Specialitys not found',
          'specialitys': [],
        }));
      }
      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'specialitys found',
        'specialitys': specialitys
            .map((e) => {
                  'id': e.id,
                  'name': e.name,
                })
            .toList(),
      }));
    });

    ///DELETE Speciality By id

    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];
      ////////// Проверяем параметры
      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой предмет
      if (!(await repository.existsSpeciality(idSpeciality: int.parse(id)))) {
        return Response.badRequest(body: 'speciality not found.');
      }

      ////////// Удаляем предмет
      try {
        await repository.deleteSpeciality(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }
      return Response.ok('Delete speciality');
    });

    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
