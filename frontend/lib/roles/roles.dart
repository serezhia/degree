import 'package:degree_app/admin/view/admin_screen.dart';
import 'package:degree_app/auth/auth.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role =
        context.read<AuthCubit>().getProfile().then((user) => user.role);

    return FutureBuilder(
      future: role,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data) {
            case 'admin':
              return const AdminScreen();
            // case 'student':
            //   return const StudentScreen();
            // case 'teacher':
            //   return const TeacherScreen();
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
