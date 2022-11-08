import 'package:bloc/bloc.dart';
import 'package:degree_app/admin/view/action_panels/add_teacher_panel.dart';
import 'package:equatable/equatable.dart';

part 'action_panel_state.dart';

class ActionPanelCubit extends Cubit<ActionPanelState> {
  ActionPanelCubit() : super(EmptyActionPanelState());

  void toggleNotificationPanel(ActionPanelState state) {
    if (state is NotificationActionPanelState) {
      emit(EmptyActionPanelState());
    } else {
      emit(NotificationActionPanelState());
    }
  }

  void toggleProfilePanel(ActionPanelState state) {
    if (state is ProfileActionPanelState) {
      emit(EmptyActionPanelState());
    } else {
      emit(ProfileActionPanelState());
    }
  }

  void toggleAddTeacherPanel(ActionPanelState state) {
    if (state is AddTeacherActionPanel) {
      emit(EmptyActionPanelState());
    } else {
      emit(AddTeacherActionPanelState());
    }
  }

  void toggleAddStudentPanel(ActionPanelState state) {
    if (state is AddStudentActionPanelState) {
      emit(EmptyActionPanelState());
    } else {
      emit(AddStudentActionPanelState());
    }
  }

  void closePanel() {
    emit(EmptyActionPanelState());
  }

  bool actionPanelIsActive(ActionPanelState state) {
    if (state is EmptyActionPanelState) {
      return false;
    } else {
      return true;
    }
  }
}
