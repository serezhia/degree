import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/auth/view/login/textfields.dart';

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
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo/logo.svg',
                      height: 30.h,
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
                            height: 30.h,
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
