import 'package:degree_app/app/feature/auth/domain/auth_repository.dart';
import 'package:degree_app/app/feature/auth/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
@test
class MockAuthRepository implements AuthRepository {
  @override
  Future getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future refreshToken({required String refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future signIn({required String username, required String password}) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(id: '1', role: 'admin', username: username);
    });
  }

  @override
  Future signOut({required String refreshToken}) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future signUp(
      {required String username,
      required String password,
      required String registerCode}) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(id: '1', role: 'admin', username: username);
    });
  }
}
