import '../../../admin_students.dart';

class AddStudentActionPanel extends StatelessWidget {
  const AddStudentActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final firstName = TextEditingController();
    final secondName = TextEditingController();
    final middleName = TextEditingController();
    final groupName = TextEditingController();
    final subgroupName = TextEditingController();
    final studentsList = context.read<StudentsPageCubit>();
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.arrow_back,
        onTap: () {
          context
              .read<ActionPanelCubit>()
              .closePanel(context.read<ActionPanelCubit>().state);
        },
      ),
      title: 'Добавить студента',
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
          icon: Icons.add,
          onTap: () {
            context
                .read<StudentPanelCubit>()
                .addStudent(
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
