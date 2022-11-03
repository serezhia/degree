// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:degree_app/main/main_screen.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.authRepository,
    this.url,
  });

  final AuthRepository authRepository;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return _GlobalProvider(
      authRepository: authRepository,
      url: url,
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
    this.url,
  });
  final Widget child;
  final AuthRepository authRepository;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            authRepository,
            url,
          ),
        ),
      ],
      child: child,
    );
  }
}
