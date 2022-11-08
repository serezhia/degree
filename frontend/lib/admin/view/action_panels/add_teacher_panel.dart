import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';

class AddTeacherActionPanel extends StatelessWidget {
  const AddTeacherActionPanel({super.key});

  @override
  Widget build(BuildContext context) => ActionPanel(
        leading: ActionPanelItem(
          icon: Icons.arrow_back,
          onTap: () {
            context.read<ActionPanelCubit>().closePanel();
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
                    children: const [
                      TextFieldDegree(
                        textFieldText: 'ФИО',
                        obscureText: false,
                        maxlines: 1,
                      ),
                      TextFieldDegree(
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
            icon: Icons.save,
            onTap: () {},
          ),
        ],
      );
}
