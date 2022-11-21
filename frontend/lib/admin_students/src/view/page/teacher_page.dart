import 'package:degree_app/admin/view/pages/users_page.dart';
import 'package:degree_app/admin_students/admin_students.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<StudentsPageCubit, StudentsPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialStudentsPageState) {
            context.read<StudentsPageCubit>().getStudents();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadingStudentsPageState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedStudentsPageState) {
            if (state.students.isEmpty) {
              return const Expanded(
                child: ColoredBox(
                  color: Color(0xFFFFFFFF),
                  child: Center(
                    child: Text('Студенты отсутствуют'),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  key: context.read<UsersState>().listStudentsKey,
                  addAutomaticKeepAlives: false,
                  itemCount: state.students.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0 ||
                            index != 0 &&
                                state.students[index - 1].secondName[0] !=
                                    state.students[index].secondName[0])
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              state.students[index].secondName[0],
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            context.read<ActionPanelCubit>().openStudentPanel();
                            context
                                .read<StudentPanelCubit>()
                                .getStudent(state.students[index].studentId);
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
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          state.students[index].secondName,
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
                                          state.students[index].firstName,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            state.students[index].middleName ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
