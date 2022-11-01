import 'package:degree_app/auth/auth.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Future getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<String> getUrl({required String url}) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => 'https://degree.serezhia.ru',
    );
  }

  @override
  Future refreshToken({required String refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> signIn({
    required String username,
    required String password,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(id: 1, role: 'admin', username: username);
    });
  }

  @override
  Future signOut({required String refreshToken}) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future signUp({
    required String username,
    required String password,
    required String registerCode,
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
