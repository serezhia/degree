import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(UsersPageState());

  void togglePage(int index) {
    switch (index) {
      case 0:
        emit(UsersPageState());
        break;
      case 1:
        emit(EntityPageState());
        break;
      case 2:
        emit(TasksPageState());
        break;
      case 3:
        emit(FilesPageState());
        break;
    }
  }
}
