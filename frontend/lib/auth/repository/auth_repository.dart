import 'package:degree_app/auth/auth.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp({
    required String username,
    required String password,
    required String registerCode,
  });

  Future<UserEntity> signIn({
    required String username,
    required String password,
  });

  Future<bool> checkRegisterCode({
    required String registerCode,
  });

  Future<dynamic> refreshToken({required String refreshToken});

  Future<void> signOut({
    required String refreshToken,
  });

  Future<bool> hostIsAlive({required String url});
}
