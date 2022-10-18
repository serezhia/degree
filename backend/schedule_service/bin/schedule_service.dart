import 'package:schedule_service/schedule_service.dart';
import 'package:schedule_service/src/data_source/postgresql/teacher_data_source.dart';
import 'package:schedule_service/src/routes/teachers_route.dart';

void main(List<String> arguments) async {
  final dbConection = PostgreSQLConnection(dbHost(), dbPort(), dbName(),
      username: dbUsername(), password: dbPassword());
  try {
    await dbConection.open();
  } catch (e) {
    print(e);
  }
  final subjectDataSource = PostgreSubjectDataSource(dbConection);
  final teacherDataSource = PostgreTeacherDataSource(dbConection);

  final app = Router();

  app.mount(
      '/subjects',
      SubjectsRoute(
        repository: subjectDataSource,
      ).router);
  app.mount(
      '/teachers',
      TeachersRoute(
              teacherRepository: teacherDataSource,
              subjectRepository: subjectDataSource)
          .router);

  final handler = Pipeline()
      .addMiddleware((logRequests()))
      .addMiddleware(handlerAuth())
      .addHandler(app);

  await serve(handler, serviceHost(), servicePort());
  print('Auth service started on ${serviceHost()}:${servicePort()}');
}
