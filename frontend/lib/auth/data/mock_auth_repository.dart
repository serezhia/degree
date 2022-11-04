import 'package:degree_app/auth/auth.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Future<UserEntity> getProfile() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => const UserEntity(
        id: 1,
        username: 'name',
        role: 'role',
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
      ),
    );
  }

  @override
  Future<void> refreshToken({required String refreshToken}) async {}

  @override
  Future<UserEntity> signIn({
    required String username,
    required String password,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      if (username == 'admin' && password == 'Test#1234') {
        return UserEntity(
          id: 1,
          username: username,
          role: 'admin',
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        );
      } else if (username == 'student' && password == 'Test#1234') {
        return UserEntity(
          id: 2,
          username: username,
          role: 'student',
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        );
      } else if (username == 'teacher' && password == 'Test#1234') {
        return UserEntity(
          id: 3,
          username: username,
          role: 'teacher',
          accessToken: 'accessToken',
          refreshToken: 'refreshToken',
        );
      } else {
        throw Exception('Invalid username or password');
      }
    });
  }

  @override
  Future<void> signOut({required String refreshToken}) async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => refreshToken,
    );
  }

  @override
  Future<UserEntity> signUp({
    required String username,
    required String password,
    required String registerCode,
  }) async {
    return Future.delayed(const Duration(seconds: 2), () {
      if (username == 'admin' && registerCode == '000000000') {
        return UserEntity(
          id: 1,
          username: username,
          role: 'admin',
        );
      } else {
        throw Exception('Opps idk what happened');
      }
    });
  }

  @override
  Future<bool> checkRegisterCode({
    required String registerCode,
  }) async {
    return Future.delayed(const Duration(seconds: 2), () {
      if (registerCode == '000000000') {
        return true;
      } else if (registerCode == '111111111') {
        throw Exception('Opps idk what happened this is backend error');
      } else {
        return false;
      }
    });
  }

  @override
  Future<bool> hostIsAlive({required String url}) async {
    return Future.delayed(const Duration(seconds: 2), () => url == 'site.ru');
  }
}
