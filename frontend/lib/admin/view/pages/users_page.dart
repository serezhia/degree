import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/degree_ui/toggle/toggle.dart';

class UsersPageProvider extends StatelessWidget {
  const UsersPageProvider({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UsersState(),
          ),
        ],
        child: const UsersPage(),
      );
}

class UsersPage extends StatelessWidget {
  const UsersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        key: context.read<UsersState>().key,
        children: [
          Row(
            children: [
              ToggleDegree(
                items: [
                  ToggleItem(lable: 'Учителя'),
                  ToggleItem(lable: 'Студенты'),
                ],
                currentIndex: context.watch<UsersState>().currentIndex,
                onTap: (value) {
                  context.read<UsersState>().currentIndex = value;
                },
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (context.read<UsersState>().currentIndex == 0) {
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
          if (context.read<UsersState>().currentIndex == 0) const TeacherList(),
          if (context.read<UsersState>().currentIndex == 1) const StudentList(),
        ],
      );
}

class TeacherList extends StatelessWidget {
  const TeacherList({super.key});

  @override
  Widget build(BuildContext context) => const Expanded(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Color(0xFFFFFFFF),
                child: Center(
                  child: Text('Список учителей пуст'),
                ),
              ),
            )
          ],
        ),
      );
}

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) => const Expanded(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: ColoredBox(
                color: Color(0xFFFFFFFF),
                child: Center(
                  child: Text('Список студентов пуст'),
                ),
              ),
            )
          ],
        ),
      );
}

class UsersState extends ChangeNotifier {
  final PageStorageKey<String> key = const PageStorageKey('users_page');

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
