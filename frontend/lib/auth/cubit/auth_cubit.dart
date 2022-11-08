import 'package:degree_app/auth/auth.dart';

part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.authRepository, [this.url]) : super(AuthInitial());

  final AuthRepository authRepository;
  String? url;

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    emit(AuthWaiting(text: 'signIn'));
    try {
      final user = await authRepository.signIn(
        username: username,
        password: password,
      );

      emit(AuthAutorized(user: user, url: url!));
    } catch (e) {
      emit(AuthError(e.toString()));
      if (url == null) {
        emit(AuthGetUrl());
      } else {
        emit(AuthNotAutorized(url: url!));
      }
    }
  }

  Future<void> checkRegisterCode({
    required String registerCode,
  }) async {
    emit(AuthWaiting(text: 'checkRegisterCode'));
    try {
      final isCorrect = await authRepository.checkRegisterCode(
        registerCode: registerCode,
      );
      if (isCorrect) {
        emit(AuthSignUp(url: url!, registerCode: registerCode));
      } else {
        emit(AuthError('Invalid register code'));
        emit(AuthGetRegisterCode(url: url!));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthGetRegisterCode(url: url!));
    }
  }

  Future<void> signUp({
    required String username,
    required String password,
    required String registerCode,
  }) async {
    emit(AuthWaiting(text: 'signUp'));
    try {
      final user = await authRepository.signUp(
        username: username,
        password: password,
        registerCode: registerCode,
      );

      emit(AuthAutorized(user: user, url: url!));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthSignUp(url: url!, registerCode: registerCode));
    }
  }

  Future<void> getUrl({
    required String host,
  }) async {
    emit(AuthWaiting(text: 'getUrl'));
    try {
      if (await authRepository.hostIsAlive(url: host)) {
        url = host;
        emit(AuthNotAutorized(url: url!));
      } else {
        emit(AuthError('Invalid adress'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logOut() async {
    emit(AuthWaiting(text: 'LogOut'));
    try {
      await authRepository.signOut(refreshToken: '');
      emit(AuthNotAutorized(url: url!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<UserEntity> getProfile() async {
    try {
      final user = await authRepository.getProfile();
      return user;
    } catch (e) {
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      final urlFromJson = json['url'] as String?;
      if (urlFromJson == null) {
        return AuthGetUrl();
      }

      url = urlFromJson;

      try {
        if (json['user'] == null) {
          return AuthNotAutorized(url: url!);
        }

        final user = UserEntity.fromJson(json['user'] as Map<String, dynamic>);

        return AuthAutorized(user: user, url: urlFromJson);
      } catch (e) {
        return AuthNotAutorized(url: url!);
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthAutorized) {
      return <String, dynamic>{
        'user': state.props[0],
        'url': state.props[1],
      };
    } else if (state is AuthNotAutorized) {
      return <String, dynamic>{
        'url': state.props[0],
      };
    } else {
      return null;
    }
  }
}
