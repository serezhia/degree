import 'package:degree_app/degree_ui/degree_ui.dart';

class OutlinedButtonDegree extends StatelessWidget {
  const OutlinedButtonDegree({
    required this.buttonText,
    required this.onPressed,
    super.key,
  });
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onPressed,
            child: Center(
              child: Text(
                buttonText,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      );
}
