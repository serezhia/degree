import 'package:auth_service/auth_service.dart';

class LogoutRoute {
  final PostgreSQLConnection db;

  LogoutRoute({required this.db});

  Router get router {
    final router = Router();

    router.post('/', (Request req) async {
      ////////// Requesting parameters
      final params = req.url.queryParameters;
      final refreshToken = params['refreshToken'];
      final fromAllDevices = params['fromAllDevices'] == 'true';
      ////////// Checking parameters
      if (refreshToken == null) {
        return Response.badRequest(body: 'refreshToken is required');
      }
      ////////// Checking if the refresh token is valid
      JWT token;
      try {
        token = await verifyToken(refreshToken, isRefreshToken: true);
      } catch (_) {
        return Response.unauthorized('Invalid refresh token: $_');
      }
      final userId = int.parse(token.subject!);
      if (!(await qExistsToken(db, userId, refreshToken))) {
        return Response.unauthorized('Refresh token is not found');
      }
      if (fromAllDevices) {
        await qTokenDeleteAll(db, userId);
      } else {
        await qTokenDelete(db, refreshToken);
      }
      return Response.ok('Logout is successful');
    });
    return router;
  }
}
