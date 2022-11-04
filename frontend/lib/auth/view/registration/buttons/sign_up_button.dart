import 'dart:developer';

import 'package:degree_app/app/app.dart';
import 'package:degree_app/auth/cubit/auth_cubit.dart';
import 'package:degree_app/auth/view/registration/registration_screen.dart';
import 'package:provider/provider.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginController>(
      context,
    ).text;

    final password = Provider.of<PasswordController>(
      context,
    ).text;

    final currentFormState = Provider.of<GlobalKey<FormState>>(
      context,
      listen: false,
    ).currentState;

    //Login RegEx
    //Login can only use letters,numbers, minimum length is 5 characters

    final loginRegEx = RegExp(
      r'^[a-zA-Z0-9](_(?!(\.|_))|\.(?!(_|\.))|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$',
    );

    //Password RegEx
    //Minimum 1 lowercase and uppercase letters,
    //Minimum one number
    //Minimum 8 characters
    //Without spaces

    final passwordRegEx = RegExp(
      r'^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[^\w\d\s:])([^\s]){8,}$',
    );
    return ElevatedButtonDegree(
      onPressed: () {
        if ((currentFormState?.validate() ?? false) &
            (loginRegEx.hasMatch(login)) &
            (passwordRegEx.hasMatch(password))) {
          final registerCode =
              context.read<AuthCubit>().state.props[1] as String?;
          log(registerCode ?? 'registerCode is null');
          context.read<AuthCubit>().signUp(
                username: login,
                password: password,
                registerCode: registerCode!,
              );
        }
      },
      buttonText: AppLocalizations.of(context).signUpButtonText,
    );
  }
}
