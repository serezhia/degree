import 'package:degree_app/admin/view/admin_screen.dart';
import 'package:degree_app/teacher/teacher.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = Future.delayed(
      const Duration(microseconds: 1),
      () => (context.read<AuthCubit>().state as AuthAutorized).user.role,
    );

    return FutureBuilder(
      future: role,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data) {
            case 'admin':
              return const AdminScreenProvider();
            // case 'student':
            //   return const StudentScreen();
            case 'teacher':
              return const TeacherScreenProvider();
            default:
              return const Scaffold(
                body: Center(
                  child: Text('Unknown role'),
                ),
              );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
