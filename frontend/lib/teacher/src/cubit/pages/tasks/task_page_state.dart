part of 'task_page_cubit.dart';

abstract class TaskPageState extends Equatable {
  const TaskPageState();

  @override
  List<Object> get props => [];
}

class InitialTaskPageState extends TaskPageState {}

class PickedTaskPageState extends TaskPageState {
  final DateTime date;

  const PickedTaskPageState({required this.date});
}

class ChangeDayTaskPageState extends TaskPageState {
  final DateTime date;

  const ChangeDayTaskPageState({required this.date});
}
