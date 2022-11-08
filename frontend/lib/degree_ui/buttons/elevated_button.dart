import 'package:degree_app/degree_ui/degree_ui.dart';

class ElevatedButtonDegree extends StatelessWidget {
  const ElevatedButtonDegree({
    required this.buttonText,
    this.onPressed,
    super.key,
  });
  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      );
}
