import 'package:degree_app/auth/auth.dart';

abstract class AuthRepository {
  Future<dynamic> signUp({
    required String username,
    required String password,
    required String registerCode,
  });

  Future<UserEntity> signIn({
    required String username,
    required String password,
  });

  Future<dynamic> getProfile();

  Future<dynamic> refreshToken({required String refreshToken});

  Future<dynamic> signOut({
    required String refreshToken,
  });

  Future<String> getUrl({required String url});
}
