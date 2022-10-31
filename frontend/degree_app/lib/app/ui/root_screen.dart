import 'package:degree_app/app/feature/auth/ui/app_loader.dart';
import 'package:degree_app/app/feature/auth/ui/components/auth_builder.dart';
import 'package:degree_app/app/feature/auth/ui/login_screen.dart';
import 'package:degree_app/app/feature/main/ui/main_screen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBuilder(
        isUnAuthenticated: ((context) => const LoginScreen()),
        isWaiting: ((context) => const AppLoader()),
        isAuthenticated: ((context, userEntity, _) =>
            MainScreen(userEntity: userEntity)));
  }
}
