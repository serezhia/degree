import 'package:auth_service/auth_service.dart';

Future<void> qTokenInsert(PostgreSQLExecutionContext ctx, int userId,
    String refreshToken, DateTime expires) async {
  ctx.query('''
    INSERT INTO tokens (user_id, refresh_token, expired_time)
    VALUES (@userId, @refreshToken, @expires);
  ''', substitutionValues: {
    'userId': userId,
    'refreshToken': refreshToken,
    'expires': expires,
  });
}

Future<void> qTokenDelete(
    PostgreSQLExecutionContext ctx, String refreshToken) async {
  ctx.query('''
    DELETE FROM tokens WHERE refresh_token = @refreshToken;
  ''', substitutionValues: {
    'refreshToken': refreshToken,
  });
}

Future<void> qTokenDeleteAll(PostgreSQLExecutionContext ctx, int userId) async {
  ctx.query('''
    DELETE FROM tokens WHERE user_id = @userId;
  ''', substitutionValues: {
    'userId': userId,
  });
}

Future<bool> qExistsToken(
    PostgreSQLConnection db, int userId, String refreshToken) async {
  final result = await db.query('''
    SELECT * FROM tokens WHERE user_id = @userId AND refresh_token = @refreshToken;
  ''', substitutionValues: {
    'userId': userId,
    'refreshToken': refreshToken,
  });
  return result.isNotEmpty;
}
