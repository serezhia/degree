import '../../student.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(SchedulePageState());

  bool disablePaddingInBodyMobile = false;

  void togglePage(int index) {
    switch (index) {
      case 0:
        emit(SchedulePageState());
        break;
      case 1:
        emit(TaskPageState());
        break;
    }
  }

  void disablePadding() {
    disablePaddingInBodyMobile = !disablePaddingInBodyMobile;
    emit(state);
  }
}
