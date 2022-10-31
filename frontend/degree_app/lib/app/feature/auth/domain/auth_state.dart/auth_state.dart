part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.waiting() = _AuthStateWaiting;

  const factory AuthState.authenticated(UserEntity userEntity) =
      _AuthStateAuthenticated;

  const factory AuthState.unAuthenticated() = _AuthStateUnAuthenticated;

  const factory AuthState.error(dynamic error) = _AuthStateError;
}
