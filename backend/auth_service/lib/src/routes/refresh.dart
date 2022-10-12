import 'package:auth_service/auth_service.dart';

class RefreshRoute {
  final PostgreSQLConnection db;

  RefreshRoute({required this.db});

  Router get router {
    final router = Router();

    router.post('/', (Request req) async {
      ////////// Requesting parameters
      final params = req.url.queryParameters;
      final refreshToken = params['refreshToken'];
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
      final newAccessToken = generateAccessToken(userId);
      final newRefreshToken = generateRefreshToken(userId);
      return Response.ok(
          jsonEncode({
            'id': userId,
            'accessToken': newAccessToken,
            'refreshToken': newRefreshToken
          }),
          headers: {HttpHeaders.contentTypeHeader: ContentType.json.mimeType});
    });

    return router;
  }
}
