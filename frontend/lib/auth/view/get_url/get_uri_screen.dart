import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/l10n/l10n.dart';
import 'package:provider/provider.dart';

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
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFieldDegree(
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
                            children: [
                              TextFieldDegree(
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
                    ElevatedButtonDegree(
                      buttonText:
                          AppLocalizations.of(context).connectButtonText,
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
                    ),
                    const SizedBox(height: 20),
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
