import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin/view/action_panels/teacher_action_panel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../degree_ui/degree_ui.dart';

class ActionPanelBuilder extends StatelessWidget {
  const ActionPanelBuilder({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActionPanelCubit, ActionPanelState>(
        builder: (context, state) {
          if (state is TeacherActionPanelState) {
            return const TeacherActionPanel();
          } else {
            return const SizedBox();
          }
        },
      );
}
