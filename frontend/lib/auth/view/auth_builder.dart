// ignore_for_file: strict_raw_type

import 'package:degree_app/auth/auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthBuilder extends StatelessWidget {
  const AuthBuilder({
    super.key,
    required this.isUnAuthenticated,
    required this.isWaiting,
    required this.isAuthenticated,
    required this.isGetUri,
    required this.isSignUp,
    required this.isGetRegisterCode,
  });

  final ValueWidgetBuilder isUnAuthenticated;
  final WidgetBuilder isWaiting;
  final WidgetBuilder isGetUri;
  final ValueWidgetBuilder isAuthenticated;
  final ValueWidgetBuilder isSignUp;
  final ValueWidgetBuilder isGetRegisterCode;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthWaiting) {
          return isWaiting(context);
        } else if (state is AuthAutorized) {
          return isAuthenticated(context, state, this);
        } else if (state is AuthNotAutorized) {
          return isUnAuthenticated(context, state, this);
        } else if (state is AuthGetRegisterCode) {
          return isGetRegisterCode(context, state, this);
        } else if (state is AuthSignUp) {
          return isSignUp(context, state, this);
        } else {
          if (!kIsWeb) {
            return isGetUri(context);
          } else {
            return isUnAuthenticated(context, state, this);
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
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message),
      ),
    );
  }
}
