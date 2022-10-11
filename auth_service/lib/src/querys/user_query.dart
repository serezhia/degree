import 'package:auth_service/auth_service.dart';

Future<bool> qUserExists(
    {required PostgreSQLConnection db, required String username}) async {
  final user = await db.mappedResultsQuery(
      "SELECT COUNT(user_id) FROM users WHERE username = @username",
      substitutionValues: {"username": username});
  return user.first['']!['count'] != 0;
}

Future<PostgreSQLResult> qInsertUser(
  PostgreSQLExecutionContext ctx, {
  required String uname,
  required String hashPass,
  required String salt,
}) async {
  return await ctx.query(
      "INSERT INTO users (username,hashedpassword,salt) VALUES (@username,@hashedpassword,@salt)",
      substitutionValues: {
        'username': uname,
        'hashedpassword': hashPass,
        'salt': salt,
      });
}

Future<int> qUserFindIdByUsername(PostgreSQLExecutionContext ctx,
    {required String uname}) async {
  final qFindUser = await ctx.mappedResultsQuery(
      "SELECT user_id FROM users WHERE username = @username",
      substitutionValues: {"username": uname});

  return qFindUser.first['users']!['user_id'];
}

Future<Map<String, String>> qUserFindHashPasswordAndSaltByUsername(
    PostgreSQLConnection db,
    {required String uname}) async {
  final qFindUser = await db.mappedResultsQuery(
      "SELECT hashedpassword,salt FROM users WHERE username = @username",
      substitutionValues: {"username": uname});

  return {
    'hashedPassword': qFindUser.first['users']!['hashedpassword'],
    'salt': qFindUser.first['users']!['salt'],
  };
}
