import 'package:degree_app/app/view/design/buttons/elevated_button.dart';
import 'package:degree_app/app/view/design/buttons/outline_button.dart';
import 'package:degree_app/app/view/design/inputform/degree_input_form.dart';
import 'package:degree_app/auth/auth.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constaints) {
        if (constaints.maxWidth > 700) {
          return const DesktopLoginScreen();
        } else {
          return const MobileLoginScreen();
        }
      },
    );
  }
}

class DesktopLoginScreen extends StatelessWidget {
  const DesktopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/logo/logo.svg',
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Степень',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 300,
                    child: TextFieldDegree(
                      textFieldText: 'Логин',
                      obscureText: false,
                      maxlines: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    width: 300,
                    child: TextFieldDegree(
                      textFieldText: 'Пароль',
                      obscureText: true,
                      maxlines: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: ElevatedButtonDegree(
                      onPressed: () {},
                      buttonText: 'Войти',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: OutlinedButtonDegree(
                      onPressed: () {},
                      buttonText: 'Зарегистрироваться',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logo/logo.svg',
                  height: 200,
                ),
                const SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                const Text(
                  'Степень',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: TextFieldDegree(
                    textFieldText: 'Логин',
                    obscureText: false,
                    maxlines: 1,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: double.infinity,
                  child: TextFieldDegree(
                    textFieldText: 'Пароль',
                    obscureText: true,
                    maxlines: 1,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButtonDegree(
                    onPressed: () {},
                    buttonText: 'Войти',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButtonDegree(
                    onPressed: () {},
                    buttonText: 'Зарегистрироваться',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
