import 'package:degree_app/student_task/student_task.dart';

part 'tasks_page_state.dart';

class TasksPageCubit extends Cubit<TasksPageState> {
  TasksPageCubit(this.taskRepository)
      : super(
          TasksPageInitial(),
        );

  final TaskRepository taskRepository;

  Future<void> getCompletedTasks() async {
    emit(TasksPageLoading());
    try {
      emit(
        TasksPageLoaded(
          tasks: await taskRepository.getCompletedTasks(),
        ),
      );
    } catch (e) {
      emit(TasksPageError(message: e.toString()));
    }
  }

  Future<void> getUncompletedTasks() async {
    emit(TasksPageLoading());
    try {
      emit(
        TasksPageLoaded(
          tasks: await taskRepository.getUncompletedTasks(),
        ),
      );
    } catch (e) {
      emit(TasksPageError(message: e.toString()));
    }
  }

  Future<void> completeTask(int id) async {
    emit(TasksPageLoading());
    try {
      await taskRepository.completeTask(id);
      emit(
        TasksPageLoaded(
          tasks: await taskRepository.getUncompletedTasks(),
        ),
      );
    } catch (e) {
      emit(TasksPageError(message: e.toString()));
    }
  }
}
