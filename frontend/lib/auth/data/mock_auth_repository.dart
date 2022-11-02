import 'dart:developer';

import 'package:degree_app/auth/auth.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Future<UserEntity> getProfile() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => const UserEntity(
        id: 1,
        username: 'test',
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
  Future<void> signOut({required String refreshToken}) async {
    log('signOut');
    await Future.delayed(
      const Duration(seconds: 2),
      () => refreshToken,
    );
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
