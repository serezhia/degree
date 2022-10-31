import 'package:degree_app/app/di/init_di.dart';
import 'package:degree_app/app/domain/app_builder.dart';
import 'package:degree_app/app/feature/auth/domain/auth_repository.dart';
import 'package:degree_app/app/feature/auth/domain/auth_state.dart/auth_cubit.dart';
import 'package:degree_app/app/ui/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppBuilder implements AppBuilder {
  @override
  Widget buildApp() {
    return const _GlobalProviders(
      child: MaterialApp(
        title: 'Degree App',
        home: RootScreen(),
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthCubit(locator<AuthRepository>())),
    ], child: child);
  }
}
