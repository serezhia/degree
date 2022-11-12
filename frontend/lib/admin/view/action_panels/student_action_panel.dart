import 'package:degree_app/admin_students/admin_students.dart';

class StudentActionPanel extends StatelessWidget {
  const StudentActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StudentPanelCubit, StudentPanelState>(
        builder: (context, state) {
          if (state is InfoStudentPanelState) {
            return const InfoStudentActionPanel();
          } else if (state is AddStudentPanelState) {
            return const AddStudentActionPanel();
          } else if (state is EditStudentPanelState) {
            return const EditStudentActionPanel();
          } else {
            return const LoadingStudentActionPanel();
          }
        },
      );
}
