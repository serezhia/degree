import 'package:degree_app/app/feature/auth/domain/auth_state.dart/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBuilder extends StatelessWidget {
  const AuthBuilder(
      {super.key,
      required this.isUnAuthenticated,
      required this.isWaiting,
      required this.isAuthenticated});

  final WidgetBuilder isUnAuthenticated;
  final WidgetBuilder isWaiting;
  final ValueWidgetBuilder isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
      return state.when(
          waiting: () => isWaiting(context),
          authenticated: ((userEntity) =>
              isAuthenticated(context, userEntity, this)),
          unAuthenticated: () => isUnAuthenticated(context),
          error: (error) => isUnAuthenticated(context));
    }, listener: ((context, state) {
      state.whenOrNull(error: (error) => _showSnackBar);
    }));
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message),
    ));
  }
}
