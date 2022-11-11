import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_page_state.dart';

class UserPageCubit extends Cubit<UserPageState> {
  UserPageCubit() : super(InitialUserPageState());

  int currentIndex = 0;

  void setIndex(int index) {
    switch (index) {
      case 0:
        currentIndex = 0;
        emit(TeacherPageState());
        break;
      case 1:
        currentIndex = 1;
        emit(StudentPageState());
        break;
    }
  }
}
