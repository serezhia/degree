import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin/view/action_panels/group_action_panel.dart';
import 'package:degree_app/admin/view/action_panels/notification_action_panel.dart';
import 'package:degree_app/admin/view/action_panels/subject_action_panel.dart';
import 'package:degree_app/admin/view/action_panels/teacher_action_panel.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionPanelBuilder extends StatelessWidget {
  const ActionPanelBuilder({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActionPanelCubit, ActionPanelState>(
        builder: (context, state) {
          if (state is TeacherActionPanelState) {
            return const TeacherActionPanel();
          } else if (state is NotificationActionPanelState) {
            return const NotificationActionPanel();
          } else if (state is SubjectActionPanelState) {
            return const SubjectActionPanel();
          } else if (state is GroupActionPanelState) {
            return const GroupActionPanel();
          } else {
            return const SizedBox();
          }
        },
      );
}
