import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'action_panel_state.dart';

class ActionPanelCubit extends Cubit<ActionPanelState> {
  ActionPanelCubit() : super(CloseActionPanelState());

  void closePanel(ActionPanelState state) {
    if (state is! CloseActionPanelState) {
      emit(CloseActionPanelState());
    }
  }

  bool actionPanelIsActive(ActionPanelState state) {
    if (state is CloseActionPanelState) {
      return false;
    } else {
      return true;
    }
  }

  void openNotificationPanel() {
    emit(NotificationActionPanelState());
  }

  void openTeacherPanel() {
    emit(TeacherActionPanelState());
  }

  void openSubjectPanel() {
    emit(SubjectActionPanelState());
  }
}
