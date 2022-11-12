import '../../../admin_students.dart';

class InfoStudentActionPanel extends StatelessWidget {
  const InfoStudentActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final student = context.read<StudentPanelCubit>().state.props[0] as Student;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Информация о студенте',
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
                      'userId: ${student.userId}',
                    ),
                    Text(
                      'studentId: ${student.studentId}',
                    ),
                    Text(
                      'Фамилия: ${student.secondName}',
                    ),
                    Text(
                      'Имя: ${student.firstName}',
                    ),
                    Text(
                      'Отчество: ${student.middleName}',
                    ),
                    Text(
                      'Группа: ${student.group.name}',
                    ),
                    Text(
                      'Подгруппа: ${student.subgroup.name}',
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
            context.read<StudentPanelCubit>().deleteStudent(student.studentId);
            context.read<ActionPanelCubit>().closePanel(
                  context.read<ActionPanelCubit>().state,
                );
            context.read<StudentsPageCubit>().getStudents();
          },
        ),
        ActionPanelItem(
          icon: Icons.edit,
          onTap: () {
            context.read<StudentPanelCubit>().openEditPanel(student);
          },
        ),
      ],
    );
  }
}
