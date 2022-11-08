part of 'action_panel_cubit.dart';

abstract class ActionPanelState extends Equatable {
  const ActionPanelState();

  @override
  List<Object> get props => [];
}

class NotificationActionPanelState extends ActionPanelState {}

class ProfileActionPanelState extends ActionPanelState {}

class AddTeacherActionPanelState extends ActionPanelState {}

class AddStudentActionPanelState extends ActionPanelState {}

class EmptyActionPanelState extends ActionPanelState {}