import 'dart:developer';

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
    emit(AuthWaiting());
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

  Future<void> getUrl({
    required String host,
  }) async {
    emit(AuthWaiting());
    try {
      if (await authRepository.hostIsAlive(url: host)) {
        log('Host is alive  ADD l10n');
        url = host;
        emit(AuthNotAutorized(url: url!));
      } else {
        emit(AuthError('Host is not alive ADD l10n'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logOut() async {
    emit(AuthWaiting());
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
      return {
        'user': state.props[0],
        'url': state.props[1],
      };
    } else if (state is AuthNotAutorized) {
      return {
        'url': state.props[0],
      };
    } else {
      return null;
    }
  }
}
