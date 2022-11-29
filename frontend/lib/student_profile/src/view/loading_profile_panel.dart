import '../../student_profile.dart';

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
