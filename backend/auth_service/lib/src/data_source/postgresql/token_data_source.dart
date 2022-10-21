import 'package:auth_service/auth_service.dart';

class PostgresTokenDataSource implements TokenRepository {
  final PostgreSQLConnection connection;

  PostgresTokenDataSource(this.connection);

  @override
  Future<Token> createToken(
      String userId, String refreshToken, DateTime expireDate) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery('''
            INSERT INTO tokens (user_id, refresh_token, expired_time)
            VALUES (@userId, @refreshToken, @expireDate)
            RETURNING token_id, user_id, refresh_token, expired_time
          ''', substitutionValues: {
        'userId': userId,
        'refreshToken': refreshToken,
        'expireDate': expireDate,
      });

      return Token(
        id: result.first['tokens']!['token_id'] as int,
        userId: result.first['tokens']!['user_id'] as int,
        refreshToken: result.first['tokens']!['refresh_token'] as String,
        expireDate: result.first['tokens']!['expired_time'] as DateTime,
      );
    });
  }

  @override
  Future<void> deleteToken(Token token) async {
    await connection.transaction((ctx) async {
      await ctx.query('''
            DELETE FROM tokens
            WHERE token_id = @id
          ''', substitutionValues: {
        'id': token.id,
      });
    });
  }

  @override
  Future<bool> existsToken(int userId, String refreshToken) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
            SELECT EXISTS (
              SELECT 1
              FROM tokens
              WHERE user_id = @userId AND refresh_token = @refreshToken
            )
          ''', substitutionValues: {
        'userId': userId,
        'refreshToken': refreshToken,
      });
      return result[0][0] as bool;
    });
  }

  @override
  Future<Token> getToken(String? id) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
            SELECT token_id, user_id, refresh_token, expire_date
            FROM tokens
            WHERE token_id = @id
          ''', substitutionValues: {
        'id': id,
      });
      return Token(
        id: result[0][0] as int,
        userId: result[0][1] as int,
        refreshToken: result[0][2] as String,
        expireDate: result[0][3] as DateTime,
      );
    });
  }

  @override
  Future<List<Token>> getUserTokens(String userId) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
            SELECT token_id, user_id, refresh_token, expire_date
            FROM tokens
            WHERE user_id = @userId
          ''', substitutionValues: {
        'userId': userId,
      });
      return result.map((row) {
        return Token(
          id: row[0] as int,
          userId: row[1] as int,
          refreshToken: row[2] as String,
          expireDate: row[3] as DateTime,
        );
      }).toList();
    });
  }

  @override
  Future<Token> updateToken(Token token) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
            UPDATE tokens
            SET refresh_token = @refreshToken, expired_time = @expireDate
            WHERE token_id = @id
            RETURNING token_id, user_id, refresh_token, expired_time
          ''', substitutionValues: {
        'id': token.id,
        'refreshToken': token.refreshToken,
        'expireDate': token.expireDate,
      });
      return Token(
        id: result[0][0] as int,
        userId: result[0][1] as int,
        refreshToken: result[0][2] as String,
        expireDate: result[0][3] as DateTime,
      );
    });
  }

  @override
  Future<Token> getTokenByRefreshToken(String refreshToken) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
            SELECT token_id, user_id, refresh_token, expired_time
            FROM tokens
            WHERE refresh_token = @refreshToken
          ''', substitutionValues: {
        'refreshToken': refreshToken,
      });
      return Token(
        id: result[0][0] as int,
        userId: result[0][1] as int,
        refreshToken: result[0][2] as String,
        expireDate: result[0][3] as DateTime,
      );
    });
  }

  @override
  Future<void> deleteUserAllTokens(String userId) {
    return connection.transaction((ctx) async {
      await ctx.query('''
            DELETE FROM tokens
            WHERE user_id = @userId
          ''', substitutionValues: {
        'userId': userId,
      });
    });
  }
}
