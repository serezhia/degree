import '../../../admin_subjects.dart';

class EditSubjectActionPanel extends StatelessWidget {
  const EditSubjectActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final subject = context.read<SubjectPanelCubit>().state.props[0] as Subject;
    final nameSubject = TextEditingController()..text = subject.name;
    final subjectsList = context.read<SubjectsPageCubit>();
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context
              .read<ActionPanelCubit>()
              .closePanel(context.read<ActionPanelCubit>().state);
        },
      ),
      title: 'Изменить предмет',
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    TextFieldDegree(
                      textEditingController: nameSubject,
                      textFieldText: 'Название предмета',
                      obscureText: false,
                      maxlines: 1,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        ActionPanelItem(
          icon: Icons.add,
          onTap: () {
            context
                .read<SubjectPanelCubit>()
                .editSubject(
                  Subject(
                    id: subject.id,
                    name: nameSubject.text,
                  ),
                )
                .then(
                  (value) => subjectsList.getSubjects(),
                );
          },
        ),
      ],
    );
  }
}
