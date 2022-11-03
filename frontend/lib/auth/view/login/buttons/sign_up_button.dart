import 'package:degree_app/auth/auth.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton();
  @override
  Widget build(BuildContext context) {
    return OutlinedButtonDegree(
      onPressed: () {},
      buttonText: AppLocalizations.of(context).signUpButtonText,
    );
  }
}
