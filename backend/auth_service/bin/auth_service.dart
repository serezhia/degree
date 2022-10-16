import 'package:auth_service/auth_service.dart';

void main(List<String> arguments) async {
  final dbConection = PostgreSQLConnection(dbHost(), dbPort(), dbName(),
      username: dbUsername(), password: dbPassword());
  try {
    await dbConection.open();
  } catch (e) {
    print(e);
  }

  final app = Router();

  app.mount('/register', RegisterRoute(db: dbConection).router);
  app.mount('/login', LoginRoute(db: dbConection).router);
  app.mount('/refresh', RefreshRoute(db: dbConection).router);
  app.mount('/logout', LogoutRoute(db: dbConection).router);

  /// ДОДЕЛАТЬ ЛОГАУТ

  final handler = Pipeline().addMiddleware((logRequests())).addHandler(app);

  await serve(handler, serviceHost(), servicePort());
  print('Auth service started on ${serviceHost()}:${servicePort()}');
}
