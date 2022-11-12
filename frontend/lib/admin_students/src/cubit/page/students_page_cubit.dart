import '../../../admin_students.dart';

part 'students_page_state.dart';

class StudentsPageCubit extends Cubit<StudentsPageState> {
  StudentsPageCubit(this.studentRepository) : super(InitialStudentsPageState());

  final StudentRepository studentRepository;

  Future<void> getStudents() async {
    emit(LoadingStudentsPageState());
    try {
      emit(
        LoadedStudentsPageState(
          students: await studentRepository.getStudentsList(),
        ),
      );
    } catch (e) {
      emit(ErrorStudentsPageState(message: e.toString()));
    }
  }
}
