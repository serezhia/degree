import 'package:schedule_service/schedule_service.dart';

class CabinetsRoute {
  final CabinetRepository cabinetRepository;
  final SubjectRepository subjectRepository;

  CabinetsRoute(
      {required this.cabinetRepository, required this.subjectRepository});

  Handler get router {
    final router = Router();

    ///POST cabinet

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final adress = params['adress'];
      final floor = params['floor'];
      final number = params['number'];
      final seats = params['seats'];
      final role = req.context['role'];

      ////////// Проверяем параметры
      if (adress == null || floor == null || number == null || seats == null) {
        return Response.badRequest(
            body: 'adress, floor, number, seats are required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой кабинет

      if (await cabinetRepository.existsCabinet(
          adress: adress, floor: int.parse(floor), number: int.parse(number))) {
        return Response.badRequest(body: 'Cabinet already exists.');
      }
      final Cabinet cabinet;
      ////////// Добавляем кабинет
      try {
        cabinet = await cabinetRepository.insertCabinet(
            adress, int.parse(floor), int.parse(number), int.parse(seats));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'cabinet added',
        'cabinet': {
          'id': '${cabinet.id}',
          'adress': cabinet.adress,
          'floor': cabinet.floor,
          'number': cabinet.number,
          'seats': cabinet.seats,
        }
      }));
    });

    //UPDATE cabinet
    router.post('/<id>', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;

      final adress = params['adress'];
      final floor = params['floor'];
      final number = params['number'];
      final seats = params['seats'];
      final role = req.context['role'];

      ////////// Проверяем параметры
      if (adress == null || floor == null || number == null || seats == null) {
        return Response.badRequest(
            body: 'adress, floor, number, seats are required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой кабинет
      if (!await cabinetRepository.existsCabinet(idCabinet: int.parse(id))) {
        return Response.badRequest(body: 'Cabinet not found.');
      }
      final Cabinet cabinet;
      ////////// Обновляем кабинет
      try {
        cabinet = await cabinetRepository.updateCabinet(Cabinet(
            id: int.parse(id),
            adress: adress,
            floor: int.parse(floor),
            number: int.parse(number),
            seats: int.parse(seats)));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'cabinet updated',
        'cabinet': {
          'id': '${cabinet.id}',
          'adress': cabinet.adress,
          'floor': cabinet.floor,
          'number': cabinet.number,
          'seats': cabinet.seats,
        }
      }));
    });

    //GET all cabinets
    router.get('/', (Request req) async {
      final List<Cabinet> cabinets;
      try {
        cabinets = await cabinetRepository.getAllCabinets();
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'cabinets found',
        'cabinets': cabinets
            .map((cabinet) => {
                  'id': cabinet.id,
                  'adress': cabinet.adress,
                  'floor': cabinet.floor,
                  'number': cabinet.number,
                  'seats': cabinet.seats,
                })
            .toList()
      }));
    });

    //GET cabinet
    router.get('/<id>', (Request req, String id) async {
      if (!await cabinetRepository.existsCabinet(idCabinet: int.parse(id))) {
        return Response.badRequest(body: 'Cabinet not found.');
      }

      final Cabinet cabinet;
      try {
        cabinet = await cabinetRepository.getCabinet(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'cabinet found',
        'cabinet': {
          'id': cabinet.id,
          'adress': cabinet.adress,
          'floor': cabinet.floor,
          'number': cabinet.number,
          'seats': cabinet.seats,
        }
      }));
    });

    //Delete cabinet
    router.delete('/<id>', (Request req, String id) async {
      final role = req.context['role'];

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await cabinetRepository.existsCabinet(idCabinet: int.parse(id))) {
        return Response.badRequest(body: 'Cabinet not found.');
      }

      try {
        await cabinetRepository.deleteCabinet(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'cabinet deleted',
      }));
    });

    //Insert subject in cabinet
    router.post('/<id>/subject', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;

      final idSubject = params['subject_id'];
      final role = req.context['role'];

      ////////// Проверяем параметры
      if (idSubject == null) {
        return Response.badRequest(body: 'idSubject is required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      ////////// Проверяем есть ли такой кабинет
      if (!await cabinetRepository.existsCabinet(idCabinet: int.parse(id))) {
        return Response.badRequest(body: 'Cabinet not found.');
      }

      ////////// Проверяем есть ли такой предмет
      if (!await subjectRepository.existsSubject(
          idSubject: int.parse(idSubject))) {
        return Response.badRequest(body: 'Subject not found.');
      }

      ////////// Проверяем есть ли такая связь
      if (await cabinetRepository.existsCabinetsSubject(
          int.parse(id), int.parse(idSubject))) {
        return Response.badRequest(body: 'CabinetSubject already exists.');
      }

      Subject cabinetSubject;
      ////////// Добавляем связь
      try {
        cabinetSubject = await cabinetRepository.addSubjectToCabinet(
            int.parse(id), int.parse(idSubject));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject added to cabinet',
        'subject': {
          'id': cabinetSubject.id,
          'name': cabinetSubject.name,
        }
      }));
    });

    //get Subjects in cabinet
    router.get('/<id>/subject', (Request req, String id) async {
      ////////// Проверяем есть ли такой кабинет
      if (!await cabinetRepository.existsCabinet(idCabinet: int.parse(id))) {
        return Response.badRequest(body: 'Cabinet not found.');
      }

      final List<Subject> subjects;
      ////////// Получаем предметы
      try {
        subjects = await cabinetRepository.getSubjectsByCabinet(int.parse(id));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subjects found',
        'subjects': subjects
            .map((subject) => {
                  'id': subject.id,
                  'name': subject.name,
                })
            .toList()
      }));
    });

    //Delete subject in cabinet
    router.delete('/<id>/subject', (Request req, String id) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final idSubject = params['subject_id'];
      final role = req.context['role'];

      if (idSubject == null) {
        return Response.badRequest(body: 'idSubject is required');
      }

      if (role != 'admin') {
        return Response.unauthorized("Haven't access");
      }

      if (!await cabinetRepository.existsCabinet(idCabinet: int.parse(id))) {
        return Response.badRequest(body: 'Cabinet not found.');
      }

      if (!await subjectRepository.existsSubject(
          idSubject: int.parse(idSubject))) {
        return Response.badRequest(body: 'Subject not found.');
      }

      if (!await cabinetRepository.existsCabinetsSubject(
          int.parse(id), int.parse(idSubject))) {
        return Response.badRequest(body: 'CabinetSubject not found.');
      }

      try {
        await cabinetRepository.deleteSubjectFromCabinet(
            int.parse(id), int.parse(idSubject));
      } catch (e) {
        return Response.internalServerError(body: e.toString());
      }

      return Response.ok(jsonEncode({
        'status': 'success',
        'message': 'subject deleted from cabinet',
      }));
    });
    final handler =
        Pipeline().addMiddleware(checkAutorization()).addHandler(router);
    return handler;
  }
}
