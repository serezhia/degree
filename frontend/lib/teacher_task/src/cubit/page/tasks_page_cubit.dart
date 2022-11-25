import 'package:degree_app/teacher_task/teacher_task.dart';

part 'tasks_page_state.dart';

class TasksPageCubit extends Cubit<TasksPageState> {
  TasksPageCubit(this.taskRepository)
      : super(
          TasksPageInitial(
            date: DateTime.now(),
          ),
        );

  final TaskRepository taskRepository;

  Future<void> setDate(DateTime date) async {
    emit(TasksPageLoading());
    try {
      emit(
        TasksPageLoaded(
          tasks: await taskRepository.getTasksByDay(date),
        ),
      );
    } catch (e) {
      emit(TasksPageError(message: e.toString()));
    }
  }

  Future<void> refreshPage(DateTime date) async {
    emit(TasksPageLoading());
    try {
      emit(
        TasksPageLoaded(
          tasks: await taskRepository.getTasksByDay(date),
        ),
      );
    } catch (e) {
      emit(TasksPageError(message: e.toString()));
    }
  }
}
