import '../../../admin_students.dart';

part 'student_panel_state.dart';

class StudentPanelCubit extends Cubit<StudentPanelState> {
  StudentPanelCubit(this.teacherRepository) : super(EmptyStudentPanelState());

  final StudentRepository teacherRepository;

  Future<void> openAddPanel() async {
    emit(AddStudentPanelState());
  }

  Future<void> openEditPanel(Student student) async {
    emit(EditStudentPanelState(student: student));
  }

  Future<void> addStudent({
    required String firstName,
    required String secondName,
    required String? middleName,
    required int groupId,
    required int subgroupId,
  }) async {
    emit(LoadingStudentPanelState());
    try {
      emit(
        InfoStudentPanelState(
          student: await teacherRepository.createStudent(
            firstName: firstName,
            secondName: secondName,
            middleName: middleName,
            groupId: groupId,
            subgroupId: subgroupId,
          ),
        ),
      );
    } catch (e) {
      emit(ErrorStudentPanelState(message: e.toString()));
    }
  }

  Future<void> getStudent(int studentId) async {
    emit(LoadingStudentPanelState());
    try {
      emit(
        InfoStudentPanelState(
          student: await teacherRepository.readStudent(studentId: studentId),
        ),
      );
    } catch (e) {
      emit(ErrorStudentPanelState(message: e.toString()));
    }
  }

  Future<void> updateStudent({
    required int studentId,
    required int userId,
    required String firstName,
    required String secondName,
    required String groupName,
    required String subgroupName,
    String? middleName,
  }) async {
    emit(LoadingStudentPanelState());
    try {
      emit(
        InfoStudentPanelState(
          student: await teacherRepository.updateStudent(
            studentId: studentId,
            userId: userId,
            firstName: firstName,
            secondName: secondName,
            middleName: middleName,
            groupName: groupName,
            subgroupName: subgroupName,
          ),
        ),
      );
    } catch (e) {
      emit(ErrorStudentPanelState(message: e.toString()));
    }
  }

  Future<void> deleteStudent(int studentId) async {
    emit(LoadingStudentPanelState());
    try {
      await teacherRepository.deleteStudent(studentId: studentId);
      emit(EmptyStudentPanelState());
    } catch (e) {
      emit(ErrorStudentPanelState(message: e.toString()));
    }
  }
}
