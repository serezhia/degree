part of 'task_page_cubit.dart';

abstract class TaskPageState extends Equatable {
  const TaskPageState();

  @override
  List<Object> get props => [];
}

class RefreshTaskPageState extends TaskPageState {
  const RefreshTaskPageState();
}

class UnCompletedTaskPageState extends TaskPageState {
  const UnCompletedTaskPageState();
}

class CompletedTaskPageState extends TaskPageState {
  const CompletedTaskPageState();
}
