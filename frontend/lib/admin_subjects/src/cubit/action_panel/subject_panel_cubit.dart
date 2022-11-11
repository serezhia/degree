import '../../../admin_subjects.dart';

part 'subject_panel_state.dart';

class SubjectPanelCubit extends Cubit<SubjectPanelState> {
  SubjectPanelCubit(this.subjectRepository) : super(EmptySubjectPanelState());

  final SubjectRepository subjectRepository;

  Future<void> openAddPanel() async {
    emit(AddSubjectPanelState());
  }

  Future<void> openEditPanel(Subject subject) async {
    emit(EditSubjectPanelState(subject: subject));
  }

  Future<void> addSubject({
    required String name,
  }) async {
    emit(LoadingSubjectPanelState());
    try {
      emit(
        InfoSubjectPanelState(
          subject: await subjectRepository.createSubject(name),
        ),
      );
    } catch (e) {
      emit(ErrorSubjectPanelState(message: e.toString()));
    }
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

  Future<void> editSubject(Subject subject) async {
    emit(LoadingSubjectPanelState());
    try {
      emit(
        InfoSubjectPanelState(
          subject: await subjectRepository.updateSubject(subject),
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
