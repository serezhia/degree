part of 'task_panel_cubit.dart';

abstract class TaskPanelState extends Equatable {
  const TaskPanelState();

  @override
  List<Object> get props => [];
}

class EmptyTaskPanelState extends TaskPanelState {}

class LoadingTaskPanelState extends TaskPanelState {}

class InfoTaskPanelState extends TaskPanelState {
  final Task task;

  const InfoTaskPanelState({required this.task});

  @override
  List<Object> get props => [task];
}

class AddTaskPanelState extends TaskPanelState {
  const AddTaskPanelState();

  @override
  List<Object> get props => [];
}

class ErrorTaskPanelState extends TaskPanelState {
  final String message;

  const ErrorTaskPanelState({required this.message});

  @override
  List<Object> get props => [message];
}
