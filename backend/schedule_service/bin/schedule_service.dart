import 'package:schedule_service/schedule_service.dart';

void main(List<String> arguments) async {
  final dbConection = PostgreSQLConnection(dbHost(), dbPort(), dbName(),
      username: dbUsername(), password: dbPassword());
  try {
    await dbConection.open();
  } catch (e) {
    print(e);
  }
  final subjectDataSource = PostgreSubjectDataSource(dbConection);

  final app = Router();

  app.mount('/subjects', SubjectsRoute(repository: subjectDataSource).router);

  final handler = Pipeline()
      .addMiddleware((logRequests()))
      .addMiddleware(handlerAuth())
      .addHandler(app);

  await serve(handler, serviceHost(), servicePort());
  print('Auth service started on ${serviceHost()}:${servicePort()}');
}
