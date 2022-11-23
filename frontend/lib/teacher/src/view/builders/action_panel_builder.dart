import '../../../teacher.dart';

class ActionPanelBuilder extends StatelessWidget {
  const ActionPanelBuilder({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActionPanelCubit, ActionPanelState>(
        builder: (context, state) {
          if (state is ProfileActionPanelState) {
            return const ProfileActionPanel();
          } else if (state is LessonActionPanelState) {
            return const LessonActionPanel();
          } else {
            return const SizedBox();
          }
        },
      );
}
