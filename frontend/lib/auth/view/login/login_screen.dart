import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<_LoginTextFields>(
          create: (context) => _LoginTextFields(),
        ),
        Provider<GlobalKey<FormState>>(
          create: (context) => GlobalKey<FormState>(),
        ),
      ],
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
      body: Form(
        key: Provider.of<GlobalKey<FormState>>(context),
        child: Row(
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
                    Text(
                      AppLocalizations.of(context).nameApp,
                      style: const TextStyle(
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
                  children: const [
                    SizedBox(
                      width: 300,
                      child: _LoginTextField(),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 300,
                      child: _PasswordTextField(),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 300,
                      child: _SignInButton(),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: _SignUpButton(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
              child: Form(
                key: Provider.of<GlobalKey<FormState>>(context),
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
                          Text(
                            AppLocalizations.of(context).nameApp,
                            style: const TextStyle(
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
                            children: const [
                              _LoginTextField(),
                              _PasswordTextField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const _SignInButton(),
                    const SizedBox(height: 20),
                    const _SignUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginTextFields {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}

class _LoginTextField extends StatelessWidget {
  const _LoginTextField();

  @override
  Widget build(BuildContext context) {
    return TextFieldDegree(
      textFieldText: AppLocalizations.of(context).loginText,
      obscureText: false,
      maxlines: 1,
      textEditingController:
          Provider.of<_LoginTextFields>(context).loginController,
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return TextFieldDegree(
      textFieldText: AppLocalizations.of(context).passwordText,
      obscureText: true,
      maxlines: 1,
      textEditingController:
          Provider.of<_LoginTextFields>(context).passwordController,
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonDegree(
      onPressed: () {
        if (Provider.of<GlobalKey<FormState>>(
              context,
              listen: false,
            ).currentState?.validate() ??
            false) {
          context.read<AuthCubit>().signIn(
                username: Provider.of<_LoginTextFields>(
                  context,
                  listen: false,
                ).loginController.text,
                password: Provider.of<_LoginTextFields>(
                  context,
                  listen: false,
                ).passwordController.text,
              );
        }
      },
      buttonText: AppLocalizations.of(context).signInButtonText,
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();
  @override
  Widget build(BuildContext context) {
    return OutlinedButtonDegree(
      onPressed: () {},
      buttonText: AppLocalizations.of(context).signUpButtonText,
    );
  }
}
