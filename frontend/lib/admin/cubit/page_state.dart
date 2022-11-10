part of 'page_cubit.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class UsersPageState extends PageState {
  final index = 0;
  final title = 'Users';

  @override
  List<Object> get props => [index, title];
}

class EntityPageState extends PageState {
  final index = 1;
  final title = 'Entity';

  @override
  List<Object> get props => [index, title];
}

class TasksPageState extends PageState {
  final index = 2;
  final title = 'Tasks';

  @override
  List<Object> get props => [index, title];
}

class FilesPageState extends PageState {
  final index = 3;
  final title = 'Files';

  @override
  List<Object> get props => [index, title];
}

class SchedulePageState extends PageState {
  final index = 4;
  final title = 'Schedule';

  @override
  List<Object> get props => [index, title];
}
