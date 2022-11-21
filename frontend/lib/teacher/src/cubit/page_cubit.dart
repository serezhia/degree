import '../../teacher.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(SchedulePageState());

  void togglePage(int index) {
    switch (index) {
      case 0:
        emit(SchedulePageState());
        break;
      case 1:
        emit(TasksPageState());
        break;
      case 2:
        emit(FilesPageState());
        break;
    }
  }
}
