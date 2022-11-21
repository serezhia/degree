import '../../../admin_teachers.dart';

class EditTeacherActionPanel extends StatelessWidget {
  const EditTeacherActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = context.read<TeacherPanelCubit>().state.props[0] as Teacher;
    final firstName = TextEditingController()..text = teacher.firstName;
    final secondName = TextEditingController()..text = teacher.secondName;
    final middleName = TextEditingController()..text = teacher.middleName ?? '';
    final subjects = TextEditingController();
    final teachersList = context.read<TeachersPageCubit>();

    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Редактирование преподавателя',
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
                      textEditingController: secondName,
                      textFieldText: 'Фамилия',
                      obscureText: false,
                      maxlines: 1,
                    ),
                    TextFieldDegree(
                      textEditingController: firstName,
                      textFieldText: 'Имя',
                      obscureText: false,
                      maxlines: 1,
                    ),
                    TextFieldDegree(
                      textEditingController: middleName,
                      textFieldText: 'Отчество',
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
          icon: Icons.done,
          onTap: () {
            context
                .read<TeacherPanelCubit>()
                .updateTeacher(
                  Teacher(
                    firstName: firstName.text,
                    secondName: secondName.text,
                    middleName: middleName.text,
                    teacherId: teacher.teacherId,
                    userId: teacher.userId,
                  ),
                )
                .then(
                  (value) => teachersList.getTeachers(),
                );
          },
        ),
      ],
    );
  }
}
