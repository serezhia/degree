part of 'action_panel_cubit.dart';

abstract class ActionPanelState extends Equatable {
  const ActionPanelState();

  @override
  List<Object> get props => [];
}

class TeacherActionPanelState extends ActionPanelState {}

class StudentActionPanelState extends ActionPanelState {}

class NotificationActionPanelState extends ActionPanelState {}

class SubjectActionPanelState extends ActionPanelState {}

class GroupActionPanelState extends ActionPanelState {}

class ScheduleActionPanelState extends ActionPanelState {}

class ProfileActionPanelState extends ActionPanelState {}

class CloseActionPanelState extends ActionPanelState {}
