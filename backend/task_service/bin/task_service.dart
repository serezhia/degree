import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:task_service/src/data_source/postgresql/task_data_source.dart';
import 'package:task_service/src/routes/tasks_route.dart';
import 'package:task_service/task_service.dart';

void main(List<String> arguments) async {
  final dbConection = PostgreSQLConnection(dbHost(), dbPort(), dbName(),
      username: dbUsername(), password: dbPassword());
  try {
    await dbConection.open();
    print('Connected to database successfully');
  } catch (e) {
    print(e);
    print('Error connecting to database');
    Future.delayed(Duration(seconds: 10), () => exit(1));
  }

  final scheduleDbConnection = PostgreSQLConnection(
      scheduleDbHost(), scheduleDbPort(), scheduleDbName(),
      username: scheduleDbUsername(), password: scheduleDbPassword());

  try {
    await scheduleDbConnection.open();
    print('Connected to schedule database successfully');
  } catch (e) {
    print(e);
    print('Error connecting to schedule database');
    Future.delayed(Duration(seconds: 10), () => exit(1));
  }

  final app = Router();

  final tagDataSource = PostgresTagDataSource(dbConection);
  final fileDataSource = PostgresTaskFileDataSource(dbConection);
  final taskDataSource =
      PostgresTaskDataSource(dbConection, scheduleDbConnection);

  if (!await Directory('user_files').exists()) {
    await Directory('user_files').create(recursive: true);
  }

  app.mount(
      '/tags/',
      TagsRoute(
        tagRepository: tagDataSource,
      ).router);

  app.mount(
      '/files/',
      FilesRoute(
        fileRepository: fileDataSource,
      ).router);

  app.mount(
      '/tasks/',
      TasksRoute(
        tagRepository: tagDataSource,
        fileRepository: fileDataSource,
        taskRepository: taskDataSource,
      ).router);

  final handler = Pipeline()
      .addMiddleware((logRequests()))
      .addMiddleware((corsHeaders()))
      .addMiddleware(handlerAuth())
      .addHandler(app);

  await serve(handler, serviceHost(), servicePort());
  print('Task service started on ${serviceHost()}:${servicePort()}');
}
