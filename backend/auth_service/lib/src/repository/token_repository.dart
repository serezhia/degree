import 'package:auth_service/auth_service.dart';

abstract class TokenRepository {
  Future<Token> createToken(
      String userId, String refreshToken, DateTime expireDate);

  Future<Token> getToken(String? id);

  Future<List<Token>> getUserTokens(String userId);

  Future<Token> updateToken(Token token);

  Future<void> deleteToken(Token token);

  Future<bool> existsToken(int userId, String refreshToken);

  Future<Token> getTokenByRefreshToken(String refreshToken);

  Future<void> deleteUserAllTokens(String userId);
}
