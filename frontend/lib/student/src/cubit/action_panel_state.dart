part of 'action_panel_cubit.dart';

abstract class ActionPanelState extends Equatable {
  const ActionPanelState();

  @override
  List<Object> get props => [];
}

class ProfileActionPanelState extends ActionPanelState {}

class CloseActionPanelState extends ActionPanelState {}
