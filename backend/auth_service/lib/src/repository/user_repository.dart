import 'package:auth_service/auth_service.dart';

abstract class UserRepository {
  Future<bool> existsUser({
    int? id,
    Role? role,
    String? firstName,
    String? secondName,
    String? middleName,
  });

  Future<User> insertUser(
    String firstName,
    String secondName,
    String? middleName,
    String registerCode,
    Role role,
  );

  Future<User> updateUser(User user);

  Future<User> getUser(int id);

  Future<List<User>> getAllUsers();

  Future<List<User>> getAllUsersByRole(Role role);

  Future<void> deleteUser(int id);

  Future<User> getUserByRegisterCode(String registerCode);

  Future<User> getUserByUsername(String username);

  Future<bool> existsUserByRegisterCode(String registerCode);

  Future<User> getUserByRefreshToken(String refreshToken);
}
