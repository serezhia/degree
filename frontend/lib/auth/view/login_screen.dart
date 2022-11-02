import 'package:degree_app/auth/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<LoginTextFields>(
      create: (context) => LoginTextFields(),
      child: LayoutBuilder(
        builder: (context, constaints) {
          if (constaints.maxWidth > 700) {
            return const DesktopLoginScreen();
          } else {
            return const MobileLoginScreen();
          }
        },
      ),
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
                  SizedBox(
                    width: 300,
                    child: TextFieldDegree(
                      textFieldText: 'Логин',
                      obscureText: false,
                      maxlines: 1,
                      textEditingController:
                          Provider.of<LoginTextFields>(context).loginController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFieldDegree(
                      textFieldText: 'Пароль',
                      obscureText: true,
                      maxlines: 1,
                      textEditingController:
                          Provider.of<LoginTextFields>(context)
                              .passwordController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: ElevatedButtonDegree(
                      onPressed: () {
                        context.read<AuthCubit>().signIn(
                              username: Provider.of<LoginTextFields>(
                                context,
                                listen: false,
                              ).loginController.text,
                              password: Provider.of<LoginTextFields>(
                                context,
                                listen: false,
                              ).passwordController.text,
                            );
                      },
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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 39),
                        child: Column(
                          children: [
                            TextFieldDegree(
                              textFieldText: 'Логин',
                              obscureText: false,
                              maxlines: 1,
                              textEditingController:
                                  Provider.of<LoginTextFields>(context)
                                      .loginController,
                            ),
                            TextFieldDegree(
                              textFieldText: 'Пароль',
                              obscureText: true,
                              maxlines: 1,
                              textEditingController:
                                  Provider.of<LoginTextFields>(context)
                                      .passwordController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButtonDegree(
                    buttonText: 'Войти',
                    onPressed: () {
                      context.read<AuthCubit>().signIn(
                            username: Provider.of<LoginTextFields>(
                              context,
                              listen: false,
                            ).loginController.text,
                            password: Provider.of<LoginTextFields>(
                              context,
                              listen: false,
                            ).passwordController.text,
                          );
                    },
                  ),
                  const SizedBox(height: 20),
                  OutlinedButtonDegree(
                    onPressed: () {},
                    buttonText: 'Зарегистрироваться',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginTextFields {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}
