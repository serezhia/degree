// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: invalid_use_of_protected_member

import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/auth/view/registration/buttons/check_code_button.dart';
import 'package:degree_app/auth/view/registration/textfields.dart';

class RegisterCodeScreen extends StatelessWidget {
  const RegisterCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirstTextConroller>(
          create: (context) => FirstTextConroller(),
        ),
        ChangeNotifierProvider<SecondTextConroller>(
          create: (context) => SecondTextConroller(),
        ),
        ChangeNotifierProvider<ThirdTextConroller>(
          create: (context) => ThirdTextConroller(),
        ),
        ChangeNotifierProvider<IsValid>(
          create: (context) => IsValid(),
        )
      ],
      child: LayoutBuilder(
        builder: (context, constaints) {
          if (constaints.maxWidth > 700) {
            return const DesktopRegisterCodeScreen();
          } else {
            return const MobileRegisterCodeScreen();
          }
        },
      ),
    );
  }
}

class DesktopRegisterCodeScreen extends StatelessWidget {
  const DesktopRegisterCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                                        onPressed: () {
                                          final url =
                                              context.read<AuthCubit>().url;
                                          context.read<AuthCubit>().emit(
                                                AuthNotAutorized(url: url!),
                                              );
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
                                    children: [
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: 301,
                                        child: RegisterCodeInput(),
                                      ),
                                      const SizedBox(height: 10),
                                      const SizedBox(
                                        width: 300,
                                        child: CheckRegistrationCodeButton(),
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

class MobileRegisterCodeScreen extends StatelessWidget {
  const MobileRegisterCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            context.read<AuthCubit>().emit(AuthNotAutorized(url: url!));
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
                          child: SizedBox(
                            width: 301,
                            child: RegisterCodeInput(),
                          ),
                        ),
                        const CheckRegistrationCodeButton(),
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
}

class FirstTextConroller extends TextEditingController {}

class SecondTextConroller extends TextEditingController {}

class ThirdTextConroller extends TextEditingController {}

class IsValid extends ChangeNotifier {
  bool _isValid = true;

  bool get isValid => _isValid;

  set isValid(bool value) {
    _isValid = value;
    notifyListeners();
  }
}
