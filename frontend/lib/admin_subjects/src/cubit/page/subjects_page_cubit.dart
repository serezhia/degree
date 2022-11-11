import '../../../admin_subjects.dart';

part 'subjects_page_state.dart';

class SubjectsPageCubit extends Cubit<SubjectsPageState> {
  SubjectsPageCubit(this.subjectRepository) : super(InitialSubjectsPageState());

  final SubjectRepository subjectRepository;

  Future<void> getSubjects() async {
    emit(LoadingSubjectsPageState());
    try {
      emit(
        LoadedSubjectsPageState(
          subjects: await subjectRepository.getSubjectsList(),
        ),
      );
    } catch (e) {
      emit(ErrorSubjectsPageState(message: e.toString()));
    }
  }
}
