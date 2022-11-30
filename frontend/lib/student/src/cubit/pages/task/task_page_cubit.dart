import '../../../../student.dart';

part 'task_page_state.dart';

class TaskPageCubit extends Cubit<TaskPageState> {
  TaskPageCubit() : super(const UnCompletedTaskPageState());

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    if (index == 0) {
      emit(const RefreshTaskPageState());
      emit(const UnCompletedTaskPageState());
    } else if (index == 1) {
      emit(const RefreshTaskPageState());
      emit(const CompletedTaskPageState());
    }
  }
}
