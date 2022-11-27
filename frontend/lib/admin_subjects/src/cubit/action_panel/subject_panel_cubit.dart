import '../../../admin_subjects.dart';

part 'subject_panel_state.dart';

class SubjectPanelCubit extends Cubit<SubjectPanelState> {
  SubjectPanelCubit(this.subjectRepository) : super(EmptySubjectPanelState());

  final SubjectRepository subjectRepository;

  Future<void> openAddPanel() async {
    emit(AddSubjectPanelState());
  }

  Future<Subject?> addSubject({
    required String name,
  }) async {
    emit(LoadingSubjectPanelState());
    try {
      final subject = subjectRepository.createSubject(name);

      emit(
        InfoSubjectPanelState(
          subject: await subject,
        ),
      );
      return subject;
    } catch (e) {
      emit(ErrorSubjectPanelState(message: e.toString()));
    }
    return null;
  }

  Future<void> getSubject(int id) async {
    emit(LoadingSubjectPanelState());
    try {
      emit(
        InfoSubjectPanelState(
          subject: await subjectRepository.getSubject(id),
        ),
      );
    } catch (e) {
      emit(ErrorSubjectPanelState(message: e.toString()));
    }
  }

  Future<void> deleteSubject(int id) async {
    emit(LoadingSubjectPanelState());
    try {
      await subjectRepository.deleteSubject(id);
      emit(EmptySubjectPanelState());
    } catch (e) {
      emit(ErrorSubjectPanelState(message: e.toString()));
    }
  }
}
