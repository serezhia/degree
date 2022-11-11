import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'entity_page_state.dart';

class EntityPageCubit extends Cubit<EnityPageState> {
  EntityPageCubit() : super(InitialEntityPageState());

  int currentIndex = 0;

  void setIndex(int index) {
    switch (index) {
      case 0:
        currentIndex = 0;
        emit(GroupsPageState());
        break;
      case 1:
        currentIndex = 1;
        emit(SubjectsPageState());
        break;
    }
  }
}
