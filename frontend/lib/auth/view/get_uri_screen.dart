import 'package:degree_app/auth/auth.dart';
import 'package:provider/provider.dart';

class GetUrl extends StatelessWidget {
  GetUrl({super.key});

  final urlTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => urlTextController,
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
                      textFieldText: 'Сайт учебного заведения',
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
                        context.read<AuthCubit>().getUrl(
                              host: Provider.of<TextEditingController>(
                                context,
                                listen: false,
                              ).text,
                            );
                      },
                      buttonText: 'Подключиться',
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
                              textFieldText: 'Сайт учебного заведения',
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
                    buttonText: 'Войти',
                    onPressed: () {},
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
