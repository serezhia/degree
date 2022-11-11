import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
}
