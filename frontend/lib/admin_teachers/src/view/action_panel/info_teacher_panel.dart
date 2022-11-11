import '../../../admin_teachers.dart';

class InfoTeacherActionPanel extends StatelessWidget {
  const InfoTeacherActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = context.read<TeacherPanelCubit>().state.props[0] as Teacher;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Информация о преподавателе',
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
                      'userId: ${teacher.userId}',
                    ),
                    Text(
                      'teacherId: ${teacher.teacherId}',
                    ),
                    Text(
                      'Фамилия: ${teacher.secondName}',
                    ),
                    Text(
                      'Имя: ${teacher.firstName}',
                    ),
                    Text(
                      'Отчество: ${teacher.middleName}',
                    ),
                    Text(
                      'Предметы: ${teacher.subjects}',
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
            context.read<TeacherPanelCubit>().deleteTeacher(teacher.teacherId);
            context.read<ActionPanelCubit>().closePanel(
                  context.read<ActionPanelCubit>().state,
                );
            context.read<TeachersPageCubit>().getTeachers();
          },
        ),
        ActionPanelItem(
          icon: Icons.edit,
          onTap: () {
            context.read<TeacherPanelCubit>().openEditPanel(teacher);
          },
        ),
      ],
    );
  }
}
