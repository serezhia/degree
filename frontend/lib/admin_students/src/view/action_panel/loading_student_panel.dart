import '../../../admin_students.dart';

class LoadingStudentActionPanel extends StatelessWidget {
  const LoadingStudentActionPanel({super.key});

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
