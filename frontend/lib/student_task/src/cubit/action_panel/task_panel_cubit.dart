import '../../../student_task.dart';

part 'task_panel_state.dart';

class TaskPanelCubit extends Cubit<TaskPanelState> {
  TaskPanelCubit(
    this.taskRepository,
  ) : super(EmptyTaskPanelState());

  final TaskRepository taskRepository;

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

  Future<void> completeTask(int id) async {}
}
