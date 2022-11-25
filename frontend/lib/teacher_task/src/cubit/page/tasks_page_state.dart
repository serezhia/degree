part of 'tasks_page_cubit.dart';

class TasksPageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TasksPageInitial extends TasksPageState {
  TasksPageInitial({required this.date});
  final DateTime date;
}

class TasksPageLoading extends TasksPageState {}

class TasksPageLoaded extends TasksPageState {
  final List<Task> tasks;
  TasksPageLoaded({required this.tasks});
}

class TasksPageError extends TasksPageState {
  final String message;
  TasksPageError({required this.message});
}
