part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthNotAutorized extends AuthState {
  AuthNotAutorized({
    required this.url,
  });

  final String url;

  @override
  List<Object?> get props => [url];
}

class AuthAutorized extends AuthState {
  AuthAutorized({
    required this.user,
    required this.url,
  });

  final String url;
  final UserEntity user;

  @override
  List<Object?> get props => [user, url];
}

class AuthWaiting extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthGetUrl extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  AuthError(this.error);

  final String error;
  @override
  List<Object?> get props => [error];
}
