import '../../../admin_subjects.dart';

class InfoSubjectActionPanel extends StatelessWidget {
  const InfoSubjectActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final subject = context.read<SubjectPanelCubit>().state.props[0] as Subject;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Информация о предмете',
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
                    Text(
                      'subjectId: ${subject.id}',
                    ),
                    Text(
                      'Название предмета: ${subject.name}',
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
          icon: Icons.delete,
          onTap: () {
            context.read<SubjectPanelCubit>().deleteSubject(subject.id);
            context.read<ActionPanelCubit>().closePanel(
                  context.read<ActionPanelCubit>().state,
                );
            context.read<SubjectsPageCubit>().getSubjects();
          },
        ),
        ActionPanelItem(
          icon: Icons.edit,
          onTap: () {
            context.read<SubjectPanelCubit>().openEditPanel(subject);
          },
        ),
      ],
    );
  }
}
