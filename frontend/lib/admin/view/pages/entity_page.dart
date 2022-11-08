import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/degree_ui/toggle/toggle.dart';

class EntityPage extends StatefulWidget {
  const EntityPage({
    super.key,
  });

  @override
  State<EntityPage> createState() => _EntityPageState();
}

class _EntityPageState extends State<EntityPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              ToggleDegree(
                items: [
                  ToggleItem(lable: 'Группы'),
                  ToggleItem(lable: 'Предметы'),
                ],
                currentIndex: currentIndex,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (currentIndex == 0) {
                    context.read<ActionPanelCubit>().toggleAddTeacherPanel(
                          context.read<ActionPanelCubit>().state,
                        );
                  } else {
                    context.read<ActionPanelCubit>().toggleAddStudentPanel(
                          context.read<ActionPanelCubit>().state,
                        );
                  }
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person_add_alt_1_outlined),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          if (currentIndex == 0) const GroupsList(),
          if (currentIndex == 1) const SubjectsList(),
        ],
      );
}

class GroupsList extends StatelessWidget {
  const GroupsList({super.key});

  @override
  Widget build(BuildContext context) => const Expanded(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Color(0xFFFFFFFF),
                child: Center(
                  child: Text('Список групп пуст'),
                ),
              ),
            )
          ],
        ),
      );
}

class SubjectsList extends StatelessWidget {
  const SubjectsList({super.key});

  @override
  Widget build(BuildContext context) => const Expanded(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Color(0xFFFFFFFF),
                child: Center(
                  child: Text('Список предметов пуст'),
                ),
              ),
            )
          ],
        ),
      );
}
