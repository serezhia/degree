import 'package:degree_app/auth/auth.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({super.key});

  @override
  Widget build(BuildContext context) => TextFieldDegree(
        autofocus: true,
        validator: (value) => validateLogin(value, context),
        textFieldText: AppLocalizations.of(context).loginText,
        obscureText: false,
        maxlines: 1,
        textEditingController: Provider.of<LoginController>(context),
      );
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) => TextFieldDegree(
        validator: (value) => validatePassword(value, context),
        textFieldText: AppLocalizations.of(context).passwordText,
        obscureText: true,
        maxlines: 1,
        textEditingController: Provider.of<PasswordController>(context),
      );
}
