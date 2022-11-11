import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/l10n/l10n.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: LoadingText(
                    message: message,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class LoadingText extends StatelessWidget {
  const LoadingText({
    required this.message,
    super.key,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    final String translatedText;

    switch (message) {
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
