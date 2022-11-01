part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthNotAutorized extends AuthState {
  AuthNotAutorized({
    required this.url,
  });

  final String url;
}

class AuthAutorized extends AuthState {
  AuthAutorized({
    required this.user,
    required this.url,
  });

  final String url;
  final UserEntity user;
}

class AuthWaiting extends AuthState {}

class AuthGetUri extends AuthState {}
