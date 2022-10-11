import 'package:auth_service/auth_service.dart';

class LoginRoute {
  final PostgreSQLConnection db;

  LoginRoute({required this.db});

  Router get router {
    final router = Router();

    router.post('/', (Request req) async {
      ////////// Запрашиваем параметры
      final params = req.url.queryParameters;
      final username = params['username'];
      final password = params['password'];
      ////////// Проверяем параметры
      if (username == null || password == null) {
        return Response.badRequest(body: 'Username and password are required');
      }
      ////////// Проверяем есть ли такой юзер
      if (!await qUserExists(db: db, username: username)) {
        return Response.badRequest(body: 'A user is not founded.');
      }

      final findUser =
          await qUserFindHashPasswordAndSaltByUsername(db, uname: username);
      final findUserSalt = findUser['salt']!;
      final findUserHashedPassword = findUser['hashedPassword'];
      final newUserHashedPassword =
          createHashedPassword(password, findUserSalt);

      if (newUserHashedPassword == findUserHashedPassword) {
        late final int userId;
        late final String accessToken;
        late final String refreshToken;
        await db.transaction((ctx) async {
          userId = await qUserFindIdByUsername(ctx, uname: username);
          accessToken = generateAccessToken(userId);
          refreshToken = generateRefreshToken(userId);
        });

        return Response.ok(
            jsonEncode({
              'id': userId,
              'accessToken': accessToken,
              'refreshToken': refreshToken
            }),
            headers: {
              HttpHeaders.contentTypeHeader: ContentType.json.mimeType
            });
      } else {
        return Response.unauthorized('Incorrect password');
      }
    });
    return router;
  }
}
