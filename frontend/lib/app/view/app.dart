import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/auth/view/registration/registration_code_screen.dart';
import 'package:degree_app/auth/view/registration/registration_screen.dart';
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
      child: ResponsiveSizer(
        builder: (p0, p1, p2) {
          return MaterialApp(
            theme: lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: AuthBuilder(
              isGetUri: (context) => const GetUrlScreen(),
              isWaiting: (context) => const LoadingScreen(),
              isUnAuthenticated: (context, value, child) => const LoginScreen(),
              isAuthenticated: (context, value, child) => const MainScreen(),
              isSignUp: (context, value, child) => const RegistrationScreen(),
              isGetRegisterCode: (context, value, child) =>
                  const RegisterCodeScreen(),
            ),
          );
        },
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
