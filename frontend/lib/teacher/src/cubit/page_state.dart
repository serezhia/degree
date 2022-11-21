part of 'page_cubit.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class SchedulePageState extends PageState {
  final index = 0;
  final title = 'Schedule';

  @override
  List<Object> get props => [index, title];
}

class TasksPageState extends PageState {
  final index = 1;
  final title = 'Tasks';

  @override
  List<Object> get props => [index, title];
}

class FilesPageState extends PageState {
  final index = 2;
  final title = 'Files';

  @override
  List<Object> get props => [index, title];
}
