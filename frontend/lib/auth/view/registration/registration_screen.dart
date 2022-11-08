// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:degree_app/auth/cubit/auth_cubit.dart';
import 'package:degree_app/auth/view/registration/buttons/sign_up_button.dart';
import 'package:degree_app/auth/view/registration/textfields.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
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
              return const DesktopRegistrationScreen();
            } else {
              return const MobileRegistrationScreen();
            }
          },
        ),
      );
}

class DesktopRegistrationScreen extends StatelessWidget {
  const DesktopRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                                                .signUnText,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_back),
                                          onPressed: () {
                                            final url =
                                                context.read<AuthCubit>().url;
                                            context.read<AuthCubit>().emit(
                                                  AuthGetRegisterCode(
                                                    url: url!,
                                                  ),
                                                );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SizedBox(
                                          width: 300,
                                          child: RegistrationLoginTextField(),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width: 300,
                                          child:
                                              RegistrationPasswordTextField(),
                                        ),
                                        SizedBox(height: 10),
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

class MobileRegistrationScreen extends StatelessWidget {
  const MobileRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          title: Text(
            AppLocalizations.of(context).signUnText,
            style: Theme.of(context).textTheme.headline6,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              final url = context.read<AuthCubit>().url;
              context.read<AuthCubit>().emit(AuthGetRegisterCode(url: url!));
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
                                RegistrationLoginTextField(),
                                RegistrationPasswordTextField(),
                              ],
                            ),
                          ),
                          const SignUpButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class PasswordController extends TextEditingController {}

class LoginController extends TextEditingController {}
