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

class TeacherList extends StatelessWidget {
  const TeacherList({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<TeachersPageCubit, TeachersPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialTeachersPageState) {
            context.read<TeachersPageCubit>().getTeachers();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadingTeachersPageState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedTeachersPageState) {
            if (state.teachers.isEmpty) {
              return const Expanded(
                child: ColoredBox(
                  color: Color(0xFFFFFFFF),
                  child: Center(
                    child: Text('Преподаватели отсутствуют'),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  key: context.read<UsersState>().listTeachersKey,
                  addAutomaticKeepAlives: false,
                  itemCount: state.teachers.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0 ||
                            index != 0 &&
                                state.teachers[index - 1].secondName[0] !=
                                    state.teachers[index].secondName[0])
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              state.teachers[index].secondName[0],
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            context.read<ActionPanelCubit>().openTeacherPanel();
                            context
                                .read<TeacherPanelCubit>()
                                .getTeacher(state.teachers[index].teacherId);
                          },
                          child: ColoredBox(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 15,
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.teachers[index].secondName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.teachers[index].firstName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.teachers[index].middleName ?? '',
                                        overflow: TextOverflow.ellipsis,
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
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Text('state: $state'),
            );
          }
        },
      );
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
