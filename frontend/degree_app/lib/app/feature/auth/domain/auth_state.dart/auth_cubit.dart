import 'package:degree_app/app/feature/auth/domain/auth_repository.dart';
import 'package:degree_app/app/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState.unAuthenticated());

  final AuthRepository authRepository;
}
