import 'package:degree_app/admin_groups/src/repository/group_repository.dart';
import 'package:degree_app/admin_groups/src/repository/speciality_repository.dart';
import 'package:degree_app/admin_groups/src/repository/subgroup_repository.dart';

import '../../../admin_students.dart';

part 'students_page_state.dart';

class StudentsPageCubit extends Cubit<StudentsPageState> {
  StudentsPageCubit({
    required this.studentRepository,
    required this.groupRepository,
    required this.specialityRepository,
    required this.subgroupRepository,
  }) : super(InitialStudentsPageState());

  final StudentRepository studentRepository;
  final GroupRepository groupRepository;
  final SpecialityRepository specialityRepository;
  final SubgroupRepository subgroupRepository;

  Future<List<Student>> getStudentsForField() async =>
      studentRepository.getStudentsList();

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
