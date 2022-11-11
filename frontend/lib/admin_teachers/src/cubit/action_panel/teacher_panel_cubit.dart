import '../../../admin_teachers.dart';

part 'teacher_panel_state.dart';

class TeacherPanelCubit extends Cubit<TeacherPanelState> {
  TeacherPanelCubit(this.teacherRepository) : super(EmptyTeacherPanelState());

  final TeacherRepository teacherRepository;

  Future<void> openAddPanel() async {
    emit(AddTeacherPanelState());
  }

  Future<void> openEditPanel(Teacher teacher) async {
    emit(EditTeacherPanelState(teacher: teacher));
  }

  Future<void> addTeacher({
    required String firstName,
    required String secondName,
    required String? middleName,
    List<Subject>? subjects,
  }) async {
    emit(LoadingTeacherPanelState());
    try {
      emit(
        InfoTeacherPanelState(
          teacher: await teacherRepository.createTeacher(
            firstName: firstName,
            secondName: secondName,
            middleName: middleName,
            subjects: subjects,
          ),
        ),
      );
    } catch (e) {
      emit(ErrorTeacherPanelState(message: e.toString()));
    }
  }

  Future<void> getTeacher(int teacherId) async {
    emit(LoadingTeacherPanelState());
    try {
      emit(
        InfoTeacherPanelState(
          teacher: await teacherRepository.readTeacher(teacherId: teacherId),
        ),
      );
    } catch (e) {
      emit(ErrorTeacherPanelState(message: e.toString()));
    }
  }

  Future<void> updateTeacher(Teacher teacher) async {
    emit(LoadingTeacherPanelState());
    try {
      emit(
        InfoTeacherPanelState(
          teacher: await teacherRepository.updateTeacher(teacher: teacher),
        ),
      );
    } catch (e) {
      emit(ErrorTeacherPanelState(message: e.toString()));
    }
  }

  Future<void> deleteTeacher(int teacherId) async {
    emit(LoadingTeacherPanelState());
    try {
      await teacherRepository.deleteTeacher(teacherId: teacherId);
      emit(EmptyTeacherPanelState());
    } catch (e) {
      emit(ErrorTeacherPanelState(message: e.toString()));
    }
  }
}
