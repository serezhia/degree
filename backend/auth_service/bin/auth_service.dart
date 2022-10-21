import 'package:auth_service/auth_service.dart';

void main(List<String> arguments) async {
  final dbConection = PostgreSQLConnection(dbHost(), dbPort(), dbName(),
      username: dbUsername(), password: dbPassword());
  try {
    await dbConection.open();
  } catch (e) {
    print(e);
    print('Error connecting to database');
    Future.delayed(Duration(seconds: 10), () => exit(1));
  }

  final userRepository = PostgresUserDataSource(dbConection);
  final tokenRepository = PostgresTokenDataSource(dbConection);

  final app = Router();

  app.mount('/tokens', TokenRoute(userRepository, tokenRepository).router);
  app.mount('/users', UsersRoute(userRepository, tokenRepository).router);

  final handler = Pipeline().addMiddleware((logRequests())).addHandler(app);

  await serve(handler, serviceHost(), servicePort());
  print('Auth service started on ${serviceHost()}:${servicePort()}');
}
