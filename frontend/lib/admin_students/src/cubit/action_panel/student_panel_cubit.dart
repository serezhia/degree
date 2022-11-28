import 'package:degree_app/admin_groups/src/model/group_model.dart';
import 'package:degree_app/admin_groups/src/model/subgroup_model.dart';

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
    required Group group,
    required Subgroup subgroup,
  }) async {
    emit(LoadingStudentPanelState());
    try {
      emit(
        InfoStudentPanelState(
          student: await teacherRepository.createStudent(
            firstName: firstName,
            secondName: secondName,
            middleName: middleName,
            group: group,
            subgroup: subgroup,
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

  Future<void> updateStudent(Student student) async {
    emit(LoadingStudentPanelState());
    try {
      emit(
        InfoStudentPanelState(
          student: await teacherRepository.updateStudent(student),
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
