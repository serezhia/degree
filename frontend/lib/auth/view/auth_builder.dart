import 'package:degree_app/auth/auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    required this.isUnAuthenticated,
    required this.isWaiting,
    required this.isAuthenticated,
    required this.isGetUri,
    required this.isSignUp,
    required this.isGetRegisterCode,
    super.key,
  });

  final WidgetBuilder isUnAuthenticated;
  final WidgetBuilder isWaiting;
  final WidgetBuilder isGetUri;
  final WidgetBuilder isAuthenticated;
  final WidgetBuilder isSignUp;
  final WidgetBuilder isGetRegisterCode;

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthWaiting) {
            return isWaiting(context);
          } else if (state is AuthAutorized) {
            return isAuthenticated(context);
          } else if (state is AuthNotAutorized) {
            return isUnAuthenticated(context);
          } else if (state is AuthGetRegisterCode) {
            return isGetRegisterCode(context);
          } else if (state is AuthSignUp) {
            return isSignUp(context);
          } else {
            if (!kIsWeb) {
              return isGetUri(context);
            } else {
              return isUnAuthenticated(context);
            }
          }
        },
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is AuthError) {
            _showSnackBar(context, state.error);
          }
        },
      );

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message),
      ),
    );
  }
}
