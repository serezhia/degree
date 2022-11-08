import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/auth/view/registration/registration_code_screen.dart';
import 'package:degree_app/auth/view/registration/registration_screen.dart';
import 'package:degree_app/roles/roles.dart';

class App extends StatelessWidget {
  const App({
    required this.authRepository,
    this.url,
    super.key,
  });

  final AuthRepository authRepository;
  final String? url;

  @override
  Widget build(BuildContext context) => _GlobalProvider(
        authRepository: authRepository,
        url: url,
        child: ResponsiveSizer(
          builder: (p0, p1, p2) => MaterialApp(
            theme: lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: AuthBuilder(
              isGetUri: (context) => const GetUrlScreen(),
              isWaiting: (context) => const LoadingScreen(),
              isUnAuthenticated: (context) => const LoginScreen(),
              isAuthenticated: (context) => const RolesScreen(),
              isSignUp: (context) => const RegistrationScreen(),
              isGetRegisterCode: (context) => const RegisterCodeScreen(),
            ),
          ),
        ),
      );
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
  Widget build(BuildContext context) => MultiBlocProvider(
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
