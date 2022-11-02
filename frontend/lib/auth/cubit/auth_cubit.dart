import 'package:degree_app/auth/auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository, this.url) : super(AuthInitial());

  final AuthRepository authRepository;
  final String? url;

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(AuthWaiting());
    try {
      final user = await authRepository.signIn(
        username: username,
        password: password,
      );
      emit(AuthAutorized(user: user, url: url!));
    } catch (e) {
      if (url == null) {
        emit(AuthGetUrl());
      } else {
        emit(AuthNotAutorized(url: url!));
      }
    }
  }

  Future<void> getUrl({
    required String host,
  }) async {
    emit(AuthWaiting());
    try {
      final url = await authRepository.getUrl(url: host);
      emit(AuthNotAutorized(url: url));
    } catch (e) {
      emit(AuthError());
    }
  }
}
