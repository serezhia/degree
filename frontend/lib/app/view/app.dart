// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:degree_app/app/theme/light_theme.dart';
import 'package:degree_app/app/view/loading_screen.dart';
import 'package:degree_app/auth/cubit/auth_cubit.dart';
import 'package:degree_app/auth/repository/auth_repository.dart';
import 'package:degree_app/auth/view/auth_builder.dart';
import 'package:degree_app/auth/view/get_uri_screen.dart';
import 'package:degree_app/auth/view/login_screen.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:degree_app/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authRepository});
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return _GlobalProvider(
      authRepository: authRepository,
      child: MaterialApp(
        theme: lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AuthBuilder(
          isGetUri: (context) => const GetUrl(),
          isWaiting: (context) => const LoadingScreen(),
          isUnAuthenticated: (context, value, child) => const LoginScreen(),
          isAuthenticated: (context, value, child) => const MainScreen(),
        ),
      ),
    );
  }
}

class _GlobalProvider extends StatelessWidget {
  const _GlobalProvider({
    required this.authRepository,
    required this.child,
  });
  final Widget child;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository),
        ),
      ],
      child: child,
    );
  }
}
