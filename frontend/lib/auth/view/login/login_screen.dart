// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/auth/view/login/textfields.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider<PasswordController>(
          create: (context) => PasswordController(),
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
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logo/logo.svg',
                            height: 250,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context).nameApp,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            '''${AppLocalizations.of(context).connectedToText} ${context.watch<AuthCubit>().url}''',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 50,
                          ),
                          width: 2,
                          color: const Color(0xFFEFEFEF),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(50),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .signInText,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                    ),
                                    if (!kIsWeb)
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          onPressed: () {
                                            context
                                                .read<AuthCubit>()
                                                .emit(AuthGetUrl());
                                          },
                                          icon: const Icon(Icons.arrow_back),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        width: 300,
                                        child: LoginTextField(),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 300,
                                        child: PasswordTextField(),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 300,
                                        child: SignInButton(),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        width: 300,
                                        child: SignUpButton(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).signInText,
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: kIsWeb
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<AuthCubit>().emit(AuthGetUrl());
                },
              ),
      ),
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
                            height: 250,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context).nameApp,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            '''${AppLocalizations.of(context).connectedToText} ${context.watch<AuthCubit>().url}''',
                            style: Theme.of(context).textTheme.headline1,
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
                              LoginTextField(),
                              PasswordTextField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SignInButton(),
                    const SizedBox(height: 20),
                    const SignUpButton(),
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

class PasswordController extends TextEditingController {}

class LoginController extends TextEditingController {}
