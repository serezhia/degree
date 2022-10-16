import 'package:auth_service/auth_service.dart';

class RegisterRoute {
  final PostgreSQLConnection db;

  RegisterRoute({required this.db});

  Router get router {
    final router = Router();

    router.post('/', (Request req) async {
      ////////// Requesting parameters
      final params = req.url.queryParameters;
      final username = params['username'];
      final password = params['password'];

      ////////// Checking parameters
      if (username == null || password == null) {
        return Response.badRequest(body: 'Username and password are required');
      }
      ////////// Checking for busy username
      if (await qUserExists(db: db, username: username)) {
        return Response.badRequest(
            body: 'A user with this name already exists.');
      }

      late final int userId;
      late final String hashPassword;
      late final String salt;
      late final String accessToken;
      late final String refreshToken;
      ////////// Generating hash from salt and password
      salt = createSalt();
      hashPassword = createHashedPassword(password, salt);

      ////////// Adding a user to the database
      await db.transaction((ctx) async {
        await qInsertUser(ctx,
            uname: username, hashPass: hashPassword, salt: salt);
        userId = await qUserFindIdByUsername(ctx, uname: username);

        ///////// Generating tokens
        accessToken = generateAccessToken(userId);
        refreshToken = generateRefreshToken(userId);
        await qTokenInsert(
            ctx, userId, refreshToken, DateTime.now().add(Duration(days: 30)));
      });

      return Response.ok(
          jsonEncode({
            'id': userId,
            'accessToken': accessToken,
            'refreshToken': refreshToken
          }),
          headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType});
    });
    return router;
  }
}
