import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin/model/teacher_model.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:degree_app/degree_ui/toggle/toggle.dart';

class UsersPageProvider extends StatelessWidget {
  const UsersPageProvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const UsersPage();
}

class UsersPage extends StatelessWidget {
  const UsersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        key: context.watch<UsersState>().pageKey,
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
          if (context.read<UsersState>().currentIndex == 0) TeacherList(),
          if (context.read<UsersState>().currentIndex == 1) const StudentList(),
        ],
      );
}

class TeacherList extends StatelessWidget {
  TeacherList({super.key});

  List<Teacher> teachers = [
    Teacher(
      firstName: 'Иван',
      secondName: 'Иванов',
      middleName: 'Иванович',
    ),
    Teacher(
      firstName: 'Сергей',
      secondName: 'Кочетков',
      middleName: 'Дмитриевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Сергеев',
      middleName: 'Александрович',
    ),
    Teacher(
      firstName: 'Алексей',
      secondName: 'Алексеев',
      middleName: 'Алексеевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Александров',
      middleName: 'Александрович',
    ),
    Teacher(
      firstName: 'Иван',
      secondName: 'Иванов',
      middleName: 'Иванович',
    ),
    Teacher(
      firstName: 'Сергей',
      secondName: 'Кочетков',
      middleName: 'Дмитриевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Сергеев',
      middleName: 'Александрович',
    ),
    Teacher(
      firstName: 'Алексей',
      secondName: 'Алексеев',
      middleName: 'Алексеевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Александров',
      middleName: 'Александрович',
    ),
    Teacher(
      firstName: 'Иван',
      secondName: 'Иванов',
      middleName: 'Иванович',
    ),
    Teacher(
      firstName: 'Сергей',
      secondName: 'Кочетков',
      middleName: 'Дмитриевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Сергеев',
      middleName: 'Александрович',
    ),
    Teacher(
      firstName: 'Алексей',
      secondName: 'Алексеев',
      middleName: 'Алексеевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Александров',
      middleName: 'Александрович',
    ),
    Teacher(
      firstName: 'Иван',
      secondName: 'Иванов',
      middleName: 'Иванович',
    ),
    Teacher(
      firstName: 'Сергей',
      secondName: 'Кочетков',
      middleName: 'Дмитриевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Сергеев',
      middleName: 'Александрович',
    ),
    Teacher(
      firstName: 'Алексей',
      secondName: 'Алексеев',
      middleName: 'Алексеевич',
    ),
    Teacher(
      firstName: 'Александр',
      secondName: 'Александров',
      middleName: 'Александрович',
    ),
  ];

  @override
  Widget build(BuildContext context) => Expanded(
        child: ColoredBox(
          color: Colors.white,
          child: ListView.builder(
            key: context.watch<UsersState>().listTeachersKey,
            itemCount: 1000,
            itemBuilder: (context, index) => Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.person),
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      teachers[1].firstName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      teachers[1].secondName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      teachers[1].middleName ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
  final PageStorageKey<String> pageKey = const PageStorageKey('users_page');
  final PageStorageKey<String> listTeachersKey =
      const PageStorageKey('list_teachers');

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
