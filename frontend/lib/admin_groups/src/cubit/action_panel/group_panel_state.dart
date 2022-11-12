part of 'group_panel_cubit.dart';

abstract class GroupPanelState extends Equatable {
  const GroupPanelState();

  @override
  List<Object> get props => [];
}

class EmptyGroupPanelState extends GroupPanelState {}

class LoadingGroupPanelState extends GroupPanelState {}

class AddGroupPanelState extends GroupPanelState {}

class InfoGroupPanelState extends GroupPanelState {
  final Group group;

  const InfoGroupPanelState({required this.group});

  @override
  List<Object> get props => [group];
}

class EditGroupPanelState extends GroupPanelState {
  final Group group;

  const EditGroupPanelState({required this.group});

  @override
  List<Object> get props => [group];
}

class ErrorGroupPanelState extends GroupPanelState {
  final String message;

  const ErrorGroupPanelState({required this.message});

  @override
  List<Object> get props => [message];
}
