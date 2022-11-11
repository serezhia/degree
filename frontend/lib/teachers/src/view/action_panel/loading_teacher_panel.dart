import '../../../teachers.dart';

class LoadingTeacherActionPanel extends StatelessWidget {
  const LoadingTeacherActionPanel({super.key});

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
