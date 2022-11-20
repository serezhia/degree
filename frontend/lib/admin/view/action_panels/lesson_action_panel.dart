import 'package:degree_app/admin_groups/admin_groups.dart';
import 'package:degree_app/admin_schedule/src/cubit/action_panel/lesson_panel_cubit.dart';
import 'package:degree_app/admin_schedule/src/view/action_panel/add_lesson_panel.dart';
import 'package:degree_app/admin_schedule/src/view/action_panel/edit_lesson_panel.dart';
import 'package:degree_app/admin_schedule/src/view/action_panel/info_lesson_panel.dart';
import 'package:degree_app/admin_schedule/src/view/action_panel/loading_subject_panel.dart';

class LessonActionPanel extends StatelessWidget {
  const LessonActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LessonPanelCubit, LessonPanelState>(
        builder: (context, state) {
          if (state is InfoLessonPanelState) {
            return const InfoLessonActionPanel();
          } else if (state is AddLessonPanelState) {
            return const AddLessonActionPanel();
          } else if (state is EditLessonPanelState) {
            return const EditLessonActionPanel();
          } else {
            return const LoadingLessonActionPanel();
          }
        },
      );
}
