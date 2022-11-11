part of 'teacher_panel_cubit.dart';

abstract class TeacherPanelState extends Equatable {
  const TeacherPanelState();

  @override
  List<Object> get props => [];
}

class EmptyTeacherPanelState extends TeacherPanelState {}

class LoadingTeacherPanelState extends TeacherPanelState {}

class AddTeacherPanelState extends TeacherPanelState {}

class InfoTeacherPanelState extends TeacherPanelState {
  final Teacher teacher;

  const InfoTeacherPanelState({required this.teacher});

  @override
  List<Object> get props => [teacher];
}

class EditTeacherPanelState extends TeacherPanelState {
  final Teacher teacher;

  const EditTeacherPanelState({required this.teacher});

  @override
  List<Object> get props => [teacher];
}

class ErrorTeacherPanelState extends TeacherPanelState {
  final String message;

  const ErrorTeacherPanelState({required this.message});

  @override
  List<Object> get props => [message];
}
