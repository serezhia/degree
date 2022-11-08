// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: invalid_use_of_protected_member

import 'package:degree_app/auth/auth.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});
  @override
  Widget build(BuildContext context) => OutlinedButtonDegree(
        buttonText: AppLocalizations.of(context).signUpButtonText,
        onPressed: () {
          final url = context.read<AuthCubit>().url;
          context.read<AuthCubit>().emit(AuthGetRegisterCode(url: url!));
        },
      );
}
