import 'package:degree_app/auth/auth.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  late String name;

  @override
  Future<UserEntity> getProfile() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => UserEntity(
        id: 1,
        username: name,
        role: 'admin',
        accessToken: 'accessToken',
        refreshToken: 'refreshToken',
      ),
    );
  }

  @override
  Future<String> getUrl({required String url}) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => url,
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
      name = username;
      return UserEntity(id: 1, role: 'admin', username: username);
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
    return UserEntity(id: 1, username: username, role: 'admin');
  }
}
