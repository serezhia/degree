import 'package:degree_app/auth/auth.dart';

class GetUrl extends StatelessWidget {
  const GetUrl({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TextEditingController(),
        ),
        Provider(create: (context) => GlobalKey<FormState>()),
      ],
      child: LayoutBuilder(
        builder: (context, constaints) {
          if (constaints.maxWidth > 700) {
            return const DesktopGetUrlScreen();
          } else {
            return const MobileGetUrlScreen();
          }
        },
      ),
    );
  }
}

class DesktopGetUrlScreen extends StatelessWidget {
  const DesktopGetUrlScreen({super.key});

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
                      height: 250,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context).nameApp,
                      style: Theme.of(context).textTheme.headline4,
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
                        validator: (value) => _validateUrl(value, context),
                        textFieldText:
                            AppLocalizations.of(context).adressHostText,
                        obscureText: false,
                        maxlines: 1,
                        textEditingController:
                            Provider.of<TextEditingController>(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 300,
                      child: ElevatedButtonDegree(
                        onPressed: () {
                          if (Provider.of<GlobalKey<FormState>>(
                                context,
                                listen: false,
                              ).currentState?.validate() ??
                              false) {
                            context.read<AuthCubit>().getUrl(
                                  host: Provider.of<TextEditingController>(
                                    context,
                                    listen: false,
                                  ).text,
                                );
                          }
                        },
                        buttonText:
                            AppLocalizations.of(context).connectButtonText,
                      ),
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

class MobileGetUrlScreen extends StatelessWidget {
  const MobileGetUrlScreen({super.key});

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
                            height: 250,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context).nameApp,
                            style: Theme.of(context).textTheme.headline4,
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
                                validator: (value) =>
                                    _validateUrl(value, context),
                                textFieldText:
                                    AppLocalizations.of(context).adressHostText,
                                obscureText: false,
                                maxlines: 1,
                                textEditingController:
                                    Provider.of<TextEditingController>(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const _GetUrlButton(),
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

class _GetUrlButton extends StatelessWidget {
  const _GetUrlButton();

  @override
  Widget build(BuildContext context) {
    final url = Provider.of<TextEditingController>(
      context,
    ).text;

    final currentFormState = Provider.of<GlobalKey<FormState>>(
      context,
      listen: false,
    ).currentState;

    final urlRegEx = RegExp(
      r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
    );

    return ElevatedButtonDegree(
      buttonText: AppLocalizations.of(context).connectButtonText,
      onPressed: () {
        if (urlRegEx.hasMatch(url) & (currentFormState?.validate() ?? false)) {
          context.read<AuthCubit>().getUrl(host: url);
        }
      },
    );
  }
}

String? _validateUrl(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return AppLocalizations.of(context).requiredFieldText;
  } else if (!RegExp(
    r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
  ).hasMatch(
    Provider.of<TextEditingController>(
      context,
      listen: false,
    ).text,
  )) {
    return AppLocalizations.of(context).inCorrectUrlTextField;
  } else {
    return null;
  }
}
