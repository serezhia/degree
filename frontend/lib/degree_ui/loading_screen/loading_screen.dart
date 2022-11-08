import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/l10n/l10n.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(25),
                child: Center(child: LoadingText()),
              ),
            ],
          ),
        ),
      );
}

class LoadingText extends StatelessWidget {
  const LoadingText({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: remove dependency
    // final text = context.read<AuthCubit>().state.props[0] as String?;
    final String translatedText;

    switch ('text') {
      case 'signIn':
        translatedText = AppLocalizations.of(context).signInLoadingText;
        break;
      case 'signUp':
        translatedText = AppLocalizations.of(context).signUpLoadingText;
        break;
      case 'checkRegisterCode':
        translatedText =
            AppLocalizations.of(context).checkingRegistrationCodeLoadingText;
        break;
      case 'getUrl':
        translatedText = AppLocalizations.of(context).getUrlLoadingText;
        break;
      case 'logOut':
        translatedText = AppLocalizations.of(context).logOutLoadingText;
        break;
      default:
        translatedText = '';
    }
    return Text(
      translatedText,
      style: Theme.of(context).textTheme.headline6,
      textAlign: TextAlign.center,
    );
  }
}