import 'package:auth_service/auth_service.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

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

  ////ADD ADMIN

  if (await userRepository
      .getAllUsersByRole(Role.admin)
      .then((value) => value.isEmpty)) {
    userRepository.insertUser('change me(fn)', 'change me(sn)',
        'change me (md)', adminRegisterCode(), Role.admin);
  }

  final app = Router();

  app.mount('/tokens', TokenRoute(userRepository, tokenRepository).router);
  app.mount('/users', UsersRoute(userRepository, tokenRepository).router);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(app);

  await serve(handler, serviceHost(), servicePort());
  print('Auth service started on ${serviceHost()}:${servicePort()}');
}
