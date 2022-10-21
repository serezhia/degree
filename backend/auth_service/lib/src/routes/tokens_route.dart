import 'package:auth_service/auth_service.dart';

class TokenRoute {
  final UserRepository userRepository;
  final TokenRepository tokenRepository;

  TokenRoute(this.userRepository, this.tokenRepository);
  Router get router {
    final router = Router();

    // Create token
    router.post('/', (Request req) async {
      final params = req.url.queryParameters;
      final username = params['username'];
      final password = params['password'];

      if (username == null || password == null) {
        return Response.badRequest(body: 'username and password are required');
      }

      final User? user;
      try {
        user = await userRepository.getUserByUsername(username);
      } catch (_) {
        return Response.badRequest(body: 'User does not exist');
      }

      final userSalt = user.salt;

      if (userSalt == null) {
        return Response.badRequest(body: 'Users salt does not exist');
      }

      if (createHashedPassword(password, userSalt) != user.hashedPassword) {
        return Response.badRequest(body: 'Incorrect password');
      }

      final refreshToken = generateRefreshToken(user.id);

      await tokenRepository.createToken(user.id.toString(), refreshToken,
          DateTime.now().add(Duration(minutes: expiredTimeRefreshToken())));
      final accessToken = generateAccessToken(user.id, user.role);

      return Response.ok(jsonEncode({
        'refreshToken': refreshToken,
        'accessToken': accessToken,
        'user': {
          'id': user.id,
          'firstName': user.firstName,
          'secondName': user.secondName,
          'middleName': user.middleName,
          'role': user.role.toString().split('.').last,
        }
      }));
    });

    // Refresh token
    router.post('/refresh', (Request req) async {
      final params = req.url.queryParameters;
      final refreshToken = params['refresh_token'];

      if (refreshToken == null) {
        return Response.badRequest(body: 'refresh_token is required ');
      }

      try {
        verifyToken(refreshToken, isRefreshToken: true);
      } catch (e) {
        return Response.badRequest(body: 'Invalid token1 $e');
      }
      final User user;
      try {
        user = await userRepository.getUserByRefreshToken(refreshToken);
      } catch (e) {
        return Response.badRequest(body: 'Invalid token2 $e');
      }
      final oldToken =
          await tokenRepository.getTokenByRefreshToken(refreshToken);
      final newAccessToken = generateAccessToken(user.id, user.role);
      final newRefreshToken = generateRefreshToken(user.id);

      final Token newToken;
      try {
        newToken = await tokenRepository.updateToken(Token(
            id: oldToken.id,
            userId: oldToken.userId,
            refreshToken: newRefreshToken,
            expireDate: DateTime.now()
                .add(Duration(minutes: expiredTimeRefreshToken()))));
      } catch (e) {
        return Response.badRequest(body: 'Invalid token3 $e');
      }

      return Response.ok(jsonEncode({
        'refresh_token': newToken.refreshToken,
        'access_token': newAccessToken,
      }));
    });

    // Delete token

    router.delete('/', (Request req) async {
      final params = req.url.queryParameters;
      final refreshToken = params['refresh_token'];

      if (refreshToken == null) {
        return Response.badRequest(body: 'refresh_token is required');
      }

      try {
        verifyToken(refreshToken, isRefreshToken: true);
      } catch (e) {
        return Response.badRequest(body: 'Invalid token');
      }

      final Token token;
      try {
        token = await tokenRepository.getTokenByRefreshToken(refreshToken);
      } catch (e) {
        return Response.badRequest(body: 'Invalid token');
      }

      await tokenRepository.deleteToken(token);

      return Response.ok('Token deleted');
    });

    //  Delete tokens

    router.delete('/<id>', (Request req, String id) async {
      final params = req.url.queryParameters;
      final refreshToken = params['refresh_token'];

      if (refreshToken == null) {
        return Response.badRequest(body: 'refresh_token is required');
      }
      print(id);
      if (!await userRepository.existsUser(id: int.parse(id))) {
        return Response.badRequest(body: 'User does not exist');
      }

      try {
        verifyToken(refreshToken, isRefreshToken: true);
      } catch (e) {
        return Response.badRequest(body: 'Invalid token');
      }

      try {
        tokenRepository.existsToken(int.parse(id), refreshToken);
      } catch (e) {
        return Response.badRequest(body: 'Invalid token');
      }

      await tokenRepository.deleteUserAllTokens(id);
      return Response.ok('Tokens deleted');
    });

    return router;
  }
}
