import '../../../teacher_task.dart';

part 'task_panel_state.dart';

class TaskPanelCubit extends Cubit<TaskPanelState> {
  TaskPanelCubit(
    this.repository,
  ) : super(EmptyTaskPanelState());

  final TaskRepository repository;

  Future<void> getTask(int id) async {
    emit(LoadingTaskPanelState());
    try {
      emit(
        InfoTaskPanelState(
          task: await repository.getTask(id),
        ),
      );
    } catch (e) {
      emit(ErrorTaskPanelState(message: e.toString()));
    }
  }
}
