import '../../../admin_teachers.dart';

part 'teachers_page_state.dart';

class TeachersPageCubit extends Cubit<TeachersPageState> {
  TeachersPageCubit(this.teacherRepository) : super(InitialTeachersPageState());

  final TeacherRepository teacherRepository;

  Future<List<Teacher>> getTeachersForField() async =>
      teacherRepository.getTeachersList();

  Future<void> getTeachers() async {
    emit(LoadingTeachersPageState());
    try {
      emit(
        LoadedTeachersPageState(
          teachers: await teacherRepository.getTeachersList(),
        ),
      );
    } catch (e) {
      emit(ErrorTeachersPageState(message: e.toString()));
    }
  }
}
