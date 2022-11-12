import 'package:degree_app/admin/cubit/pages/users/user_page_cubit.dart';
import 'package:degree_app/admin_students/admin_students.dart';

import 'package:degree_app/admin_teachers/admin_teachers.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<UserPageCubit>().currentIndex;
    return Column(
      children: [
        Row(
          children: [
            ToggleDegree(
              items: [
                ToggleItem(lable: 'Учителя'),
                ToggleItem(lable: 'Студенты'),
              ],
              currentIndex: currentIndex,
              onTap: (value) {
                context.read<UserPageCubit>().setIndex(value);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                if (currentIndex == 0) {
                  context.read<ActionPanelCubit>().openTeacherPanel();
                  context.read<TeacherPanelCubit>().openAddPanel();
                } else {
                  context.read<ActionPanelCubit>().openStudentPanel();
                  context.read<StudentPanelCubit>().openAddPanel();
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
        if (currentIndex == 0) const TeacherList(),
        if (currentIndex == 1) const StudentList(),
      ],
    );
  }
}

class UsersState extends ChangeNotifier {
  final PageStorageKey<String> listTeachersKey =
      const PageStorageKey('list_teachers');

  final PageStorageKey<String> listStudentsKey =
      const PageStorageKey('list_students');

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
