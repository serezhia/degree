import '../../../admin_teachers.dart';

class AddTeacherActionPanel extends StatelessWidget {
  const AddTeacherActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final firstName = TextEditingController();
    final secondName = TextEditingController();
    final middleName = TextEditingController();
    final subjects = TextEditingController();
    final teachersList = context.read<TeachersPageCubit>();
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context
              .read<ActionPanelCubit>()
              .closePanel(context.read<ActionPanelCubit>().state);
        },
      ),
      title: 'Добавить преподавателя',
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
          icon: Icons.add,
          onTap: () {
            context
                .read<TeacherPanelCubit>()
                .addTeacher(
                  firstName: firstName.text,
                  secondName: secondName.text,
                  middleName: middleName.text,
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
