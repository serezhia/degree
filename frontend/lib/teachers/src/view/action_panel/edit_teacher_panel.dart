import 'package:degree_app/admin/cubit/action_panel_cubit.dart';

import '../../../teachers.dart';

class EditTeacherActionPanel extends StatelessWidget {
  const EditTeacherActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = context.read<TeacherPanelCubit>().state.props[0] as Teacher;
    final firstName = TextEditingController()..text = teacher.firstName;
    final secondName = TextEditingController()..text = teacher.secondName;
    final middleName = TextEditingController()..text = teacher.middleName ?? '';
    final subjects = TextEditingController();

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
                    TextFieldDegree(
                      textEditingController: subjects,
                      textFieldText: 'Предметы',
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
          icon: Icons.delete,
          onTap: () {
            context.read<TeacherPanelCubit>().deleteTeacher(teacher.teacherId);
            context.read<ActionPanelCubit>().closePanel(
                  context.read<ActionPanelCubit>().state,
                );
          },
        ),
        ActionPanelItem(
          icon: Icons.edit,
          onTap: () {
            context.read<TeacherPanelCubit>().updateTeacher(teacher);
          },
        ),
      ],
    );
  }
}
