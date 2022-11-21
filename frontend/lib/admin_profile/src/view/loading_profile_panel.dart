import 'package:degree_app/degree_ui/degree_ui.dart';

class LoadingProfileActionPanel extends StatelessWidget {
  const LoadingProfileActionPanel({super.key});

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
