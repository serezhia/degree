import '../../../student.dart';

class LessonActionPanel extends StatelessWidget {
  const LessonActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LessonPanelCubit, LessonPanelState>(
        builder: (context, state) {
          if (state is InfoLessonPanelState) {
            return const InfoLessonActionPanel();
          } else {
            return const LoadingLessonActionPanel();
          }
        },
      );
}
