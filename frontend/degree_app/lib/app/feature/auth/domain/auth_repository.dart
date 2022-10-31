abstract class AuthRepository {
  Future<dynamic> signUp(
      {required String username,
      required String password,
      required String registerCode});

  Future<dynamic> signIn({
    required String username,
    required String password,
  });

  Future<dynamic> getProfile();

  Future<dynamic> refreshToken({required String refreshToken});

  Future<dynamic> signOut({
    required String refreshToken,
  });
}
