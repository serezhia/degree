import 'package:auth_service/auth_service.dart';

class PostgresUserDataSource implements UserRepository {
  final PostgreSQLConnection connection;

  PostgresUserDataSource(this.connection);

  @override
  Future<void> deleteUser(int id) {
    return connection.mappedResultsQuery(
      'DELETE FROM users WHERE user_id = @id',
      substitutionValues: {'id': id},
    );
  }

  @override
  Future<bool> existsUser(
      {int? id,
      Role? role,
      String? firstName,
      String? secondName,
      String? middleName}) {
    return connection.mappedResultsQuery(
      'SELECT * FROM users WHERE user_id = @id',
      substitutionValues: {
        'id': id,
      },
    ).then((value) {
      return value.isNotEmpty;
    });
  }

  @override
  Future<List<User>> getAllUsers() {
    return connection
        .mappedResultsQuery(
          'SELECT * FROM users',
        )
        .then((value) => value.map((e) {
              return User(
                id: e['users']!['user_id'] as int,
                role: Role.values.firstWhere(
                    (el) => el.toString() == '${e['users']!['role']!}'),
                firstName: e['users']!['first_name'] as String,
                secondName: e['users']!['second_name'] as String,
                middleName: e['users']!['middle_name'] as String?,
                username: e['users']!['username'] as String?,
                registerCode: e['users']!['register_code'] as String?,
              );
            }).toList());
  }

  @override
  Future<List<User>> getAllUsersByRole(Role role) {
    return connection.mappedResultsQuery(
      'SELECT * FROM users WHERE role = @role',
      substitutionValues: {'role': role.toString()},
    ).then((value) => value
        .map((e) => User(
              id: e['user_id'] as int,
              role: Role.values[e['role'] as int],
              firstName: e['first_name'] as String,
              secondName: e['second_name'] as String,
              middleName: e['middle_name'] as String,
              username: e['username'] as String,
              registerCode: e['register_code'] as String,
            ))
        .toList());
  }

  @override
  Future<User> getUser(int id) {
    return connection.mappedResultsQuery(
      'SELECT * FROM users WHERE user_id = @id',
      substitutionValues: {'id': id},
    ).then((value) {
      if (value.isEmpty) {
        throw Exception('User with id $id not found');
      }

      return User(
        id: value.first['users']!['user_id'] as int,
        firstName: value.first['users']!['first_name'] as String,
        secondName: value.first['users']!['second_name'] as String,
        middleName: value.first['users']!['middle_name'] as String?,
        username: value.first['users']!['username'] as String?,
        hashedPassword: value.first['users']!['hashed_password'] as String?,
        salt: value.first['users']!['salt'] as String?,
        role: Role.values.firstWhere(
          (element) =>
              element.toString() == value.first['users']!['role'] as String,
        ),
        registerCode: value.first['users']!['register_code'] as String?,
      );
    });
  }

  @override
  Future<User> updateUser(User user) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.mappedResultsQuery(
        'UPDATE users SET first_name = @firstName, second_name = @secondName, middle_name = @middleName, role = @role, username = @username, hashed_password = @hashedPassword, salt = @salt, register_code = @registerCode WHERE user_id = @id RETURNING *',
        substitutionValues: {
          'id': user.id,
          'firstName': user.firstName,
          'secondName': user.secondName,
          'middleName': user.middleName,
          'username': user.username,
          'hashedPassword': user.hashedPassword,
          'salt': user.salt,
          'role': user.role.toString(),
          'registerCode': null,
        },
      );

      return User(
        id: result.first['users']!['user_id'] as int,
        firstName: result.first['users']!['first_name'] as String,
        secondName: result.first['users']!['second_name'] as String,
        middleName: result.first['users']!['middle_name'] as String?,
        username: result.first['users']!['username'] as String,
        hashedPassword: result.first['users']!['hashed_password'] as String,
        salt: result.first['users']!['salt'] as String,
        role: Role.values.firstWhere(
          (element) =>
              element.toString() == result.first['users']!['role'] as String,
        ),
        registerCode: null,
      );
    });
  }

  @override
  Future<User> insertUser(
    String firstName,
    String secondName,
    String? middleName,
    String registerCode,
    Role role,
  ) async {
    return await connection.transaction((ctx) async {
      final result = await ctx.query('''
        INSERT INTO users (first_name, second_name, middle_name, role, register_code)
        VALUES (@firstName, @secondName, @middleName, @role, @registerCode)
        RETURNING user_id, first_name, second_name, middle_name, role, register_code;
      ''', substitutionValues: {
        'firstName': firstName,
        'secondName': secondName,
        'middleName': middleName,
        'registerCode': registerCode,
        'role': role.toString(),
      });
      return User(
        id: result[0][0] as int,
        firstName: result[0][1] as String,
        secondName: result[0][2] as String,
        middleName: result[0][3] as String?,
        role: Role.values.firstWhere(
            (element) => element.toString() == result[0][4] as String),
        registerCode: result[0][5] as String?,
      );
    });
  }

  @override
  Future<bool> existsUserByRegisterCode(String registerCode) {
    return connection.mappedResultsQuery(
      'SELECT EXISTS(SELECT 1 FROM users WHERE register_code = @registerCode)',
      substitutionValues: {'registerCode': registerCode},
    ).then((value) => value.isNotEmpty);
  }

  @override
  Future<User> getUserByRegisterCode(String registerCode) {
    return connection.mappedResultsQuery(
      'SELECT * FROM users WHERE register_code = @registerCode',
      substitutionValues: {'registerCode': registerCode},
    ).then((value) {
      return User(
        id: value.first['users']!['user_id'] as int,
        firstName: value.first['users']!['first_name'] as String,
        secondName: value.first['users']!['second_name'] as String,
        middleName: value.first['users']!['middle_name'] as String?,
        role: Role.values.firstWhere(
          (element) =>
              element.toString() == value.first['users']!['role'] as String,
        ),
        registerCode: value.first['users']!['register_code'] as String?,
      );
    });
  }

  @override
  Future<User> getUserByUsername(String username) {
    return connection.mappedResultsQuery(
      'SELECT * FROM users WHERE username = @username',
      substitutionValues: {'username': username},
    ).then((value) {
      return User(
        id: value.first['users']!['user_id'] as int,
        firstName: value.first['users']!['first_name'] as String,
        secondName: value.first['users']!['second_name'] as String,
        middleName: value.first['users']!['middle_name'] as String?,
        username: value.first['users']!['username'] as String?,
        salt: value.first['users']!['salt'] as String?,
        hashedPassword: value.first['users']!['hashed_password'] as String?,
        role: Role.values.firstWhere(
          (element) =>
              element.toString() == value.first['users']!['role'] as String,
        ),
        registerCode: value.first['users']!['register_code'] as String?,
      );
    });
  }

  @override
  Future<User> getUserByRefreshToken(String refreshToken) async {
    return await connection.mappedResultsQuery(
      'SELECT * FROM users WHERE user_id = (SELECT user_id FROM tokens WHERE refresh_token = @refreshToken)',
      substitutionValues: {'refreshToken': refreshToken},
    ).then((value) {
      return User(
        id: value.first['users']!['user_id'] as int,
        firstName: value.first['users']!['first_name'] as String,
        secondName: value.first['users']!['second_name'] as String,
        middleName: value.first['users']!['middle_name'] as String?,
        username: value.first['users']!['username'] as String?,
        salt: value.first['users']!['salt'] as String?,
        hashedPassword: value.first['users']!['hashed_password'] as String?,
        role: Role.values.firstWhere(
          (element) =>
              element.toString() == value.first['users']!['role'] as String,
        ),
        registerCode: value.first['users']!['register_code'] as String?,
      );
    });
  }
}
