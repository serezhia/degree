part of 'student_panel_cubit.dart';

abstract class StudentPanelState extends Equatable {
  const StudentPanelState();

  @override
  List<Object> get props => [];
}

class EmptyStudentPanelState extends StudentPanelState {}

class LoadingStudentPanelState extends StudentPanelState {}

class AddStudentPanelState extends StudentPanelState {}

class InfoStudentPanelState extends StudentPanelState {
  final Student student;

  const InfoStudentPanelState({required this.student});

  @override
  List<Object> get props => [student];
}

class EditStudentPanelState extends StudentPanelState {
  final Student student;

  const EditStudentPanelState({required this.student});

  @override
  List<Object> get props => [student];
}

class ErrorStudentPanelState extends StudentPanelState {
  final String message;

  const ErrorStudentPanelState({required this.message});

  @override
  List<Object> get props => [message];
}
