import '../../../teacher_task.dart';

part 'task_panel_state.dart';

class TaskPanelCubit extends Cubit<TaskPanelState> {
  TaskPanelCubit(
    this.taskRepository,
    this.mainTeacherRepository,
  ) : super(EmptyTaskPanelState());

  final TaskRepository taskRepository;

  final MainTeacherRepository mainTeacherRepository;

  Future<List<Subject>> getSubjectsForField() async {
    final subjects = await mainTeacherRepository.getSubjectsList();
    return subjects;
  }

  Future<List<Student>> getStudentsForField() async {
    final students = await mainTeacherRepository.getStudentsList();
    return students;
  }

  Future<List<Group>> getGroupsForField() async {
    final groups = await mainTeacherRepository.getGroups();
    return groups;
  }

  Future<List<Subgroup>> getSubgroupsForField() async {
    final subgroups = await mainTeacherRepository.getSubgroups();
    return subgroups;
  }

  Future<void> getTask(int id) async {
    emit(LoadingTaskPanelState());
    try {
      emit(
        InfoTaskPanelState(
          task: await taskRepository.getTask(id),
        ),
      );
    } catch (e) {
      emit(ErrorTaskPanelState(message: e.toString()));
    }
  }

  Future<void> addTask({
    required Subject subject,
    required String content,
    required DeadLineType deadLineType,
    required DateTime? deadLineDate,
    List<TagTask>? tags,
    List<FileDegree>? files,
    Group? group,
    Subgroup? subgroup,
    Student? student,
  }) async {
    emit(LoadingTaskPanelState());
    try {
      await taskRepository.addTask(
        subject: subject,
        teacher: mockUserList.firstWhere((user) => user is Teacher) as Teacher,
        content: content,
        deadLineType: deadLineType,
        deadLineDate: deadLineDate,
        tags: tags,
        files: files,
        group: group,
        subgroup: subgroup,
        student: student,
      );
      emit(const AddTaskPanelState());
    } catch (e) {
      emit(ErrorTaskPanelState(message: e.toString()));
    }
  }

  Future<void> openAddPanel() async {
    emit(const AddTaskPanelState());
  }
}
