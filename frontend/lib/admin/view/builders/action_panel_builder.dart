import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin/view/action_panels/add_student_panel.dart';
import 'package:degree_app/admin/view/action_panels/add_teacher_panel.dart';
import 'package:degree_app/admin/view/action_panels/notification_panel.dart';
import 'package:degree_app/admin/view/action_panels/profile_panel.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionPanelBuilder extends StatelessWidget {
  const ActionPanelBuilder({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActionPanelCubit, ActionPanelState>(
        builder: (context, state) {
          if (state is NotificationActionPanelState) {
            return const NotificationActionPanel();
          } else if (state is ProfileActionPanelState) {
            return const ProfileActionPanel();
          } else if (state is AddTeacherActionPanelState) {
            return const AddTeacherActionPanel();
          } else if (state is AddStudentActionPanelState) {
            return const AddStudentActionPanel();
          } else {
            return Container();
          }
        },
      );
}
