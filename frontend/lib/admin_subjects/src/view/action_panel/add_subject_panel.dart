import '../../../admin_subjects.dart';

class AddSubjectActionPanel extends StatelessWidget {
  const AddSubjectActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final nameSubject = TextEditingController();

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
      title: 'Добавить предмет',
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
                .addSubject(
                  name: nameSubject.text,
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
