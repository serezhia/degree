import '../../../../admin_subjects/admin_subjects.dart';

class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SubjectsPageCubit, SubjectsPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InitialSubjectsPageState) {
            context.read<SubjectsPageCubit>().getSubjects();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadingSubjectsPageState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedSubjectsPageState) {
            if (state.subjects.isEmpty) {
              return const Expanded(
                child: ColoredBox(
                  color: Color(0xFFFFFFFF),
                  child: Center(
                    child: Text('Предметы отсутствуют'),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  key: context.read<EntitiesState>().listSubjectsKey,
                  addAutomaticKeepAlives: false,
                  itemCount: state.subjects.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0 ||
                            index != 0 &&
                                state.subjects[index - 1].name[0] !=
                                    state.subjects[index].name[0])
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              state.subjects[index].name[0],
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            context.read<ActionPanelCubit>().openSubjectPanel();
                            context
                                .read<SubjectPanelCubit>()
                                .getSubject(state.subjects[index].id);
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
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        state.subjects[index].name,
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
