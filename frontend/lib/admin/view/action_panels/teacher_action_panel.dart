import 'package:degree_app/admin_teachers/admin_teachers.dart';

class TeacherActionPanel extends StatelessWidget {
  const TeacherActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TeacherPanelCubit, TeacherPanelState>(
        builder: (context, state) {
          if (state is InfoTeacherPanelState) {
            return const InfoTeacherActionPanel();
          } else if (state is AddTeacherPanelState) {
            return const AddTeacherActionPanel();
          } else if (state is EditTeacherPanelState) {
            return const EditTeacherActionPanel();
          } else {
            return const LoadingTeacherActionPanel();
          }
        },
      );
}
