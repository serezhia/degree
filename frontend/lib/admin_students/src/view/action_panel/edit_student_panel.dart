import '../../../admin_students.dart';

class EditStudentActionPanel extends StatelessWidget {
  const EditStudentActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final student = context.read<StudentPanelCubit>().state.props[0] as Student;
    final firstName = TextEditingController()..text = student.firstName;
    final secondName = TextEditingController()..text = student.secondName;
    final middleName = TextEditingController()..text = student.middleName ?? '';
    final groupName = TextEditingController()..text = student.group.name;
    final subgroupName = TextEditingController()..text = student.subgroup.name;
    final studentsList = context.read<StudentsPageCubit>();

    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(
                context.read<ActionPanelCubit>().state,
              );
        },
      ),
      title: 'Редактирование студента',
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
                    TextFieldDegree(
                      textEditingController: groupName,
                      textFieldText: 'Группа',
                      obscureText: false,
                      maxlines: 1,
                    ),
                    TextFieldDegree(
                      textEditingController: subgroupName,
                      textFieldText: 'Подгруппа',
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
                .read<StudentPanelCubit>()
                .updateStudent(
                  userId: student.userId!,
                  studentId: student.studentId,
                  firstName: firstName.text,
                  secondName: secondName.text,
                  middleName: middleName.text,
                  groupName: groupName.text,
                  subgroupName: subgroupName.text,
                )
                .then(
                  (value) => studentsList.getStudents(),
                );
          },
        ),
      ],
    );
  }
}
