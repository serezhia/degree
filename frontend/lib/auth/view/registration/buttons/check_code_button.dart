import 'package:degree_app/auth/auth.dart';
import 'package:degree_app/auth/view/registration/registration_code_screen.dart';

class CheckRegistrationCodeButton extends StatelessWidget {
  const CheckRegistrationCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final firstText = Provider.of<FirstTextConroller>(context).text;
    final secondText = Provider.of<SecondTextConroller>(context).text;
    final thirdText = Provider.of<ThirdTextConroller>(context).text;

    return ElevatedButtonDegree(
      buttonText: AppLocalizations.of(context).continueButtonText,
      onPressed: () {
        if (firstText.length == 3 &&
            secondText.length == 3 &&
            thirdText.length == 3) {
          context.read<AuthCubit>().checkRegisterCode(
                registerCode: '$firstText$secondText$thirdText',
              );
        } else {
          Provider.of<IsValid>(context, listen: false).isValid = false;
        }
      },
    );
  }
}
