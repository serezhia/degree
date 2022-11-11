import 'package:degree_app/admin_subjects/admin_subjects.dart';

class SubjectActionPanel extends StatelessWidget {
  const SubjectActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SubjectPanelCubit, SubjectPanelState>(
        builder: (context, state) {
          if (state is InfoSubjectPanelState) {
            return const InfoSubjectActionPanel();
          } else if (state is AddSubjectPanelState) {
            return const AddSubjectActionPanel();
          } else if (state is EditSubjectPanelState) {
            return const EditSubjectActionPanel();
          } else {
            return const LoadingSubjectActionPanel();
          }
        },
      );
}
