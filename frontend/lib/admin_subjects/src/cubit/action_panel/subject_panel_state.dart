part of 'subject_panel_cubit.dart';

abstract class SubjectPanelState extends Equatable {
  const SubjectPanelState();

  @override
  List<Object> get props => [];
}

class EmptySubjectPanelState extends SubjectPanelState {}

class LoadingSubjectPanelState extends SubjectPanelState {}

class AddSubjectPanelState extends SubjectPanelState {}

class InfoSubjectPanelState extends SubjectPanelState {
  final Subject subject;

  const InfoSubjectPanelState({required this.subject});

  @override
  List<Object> get props => [subject];
}

class ErrorSubjectPanelState extends SubjectPanelState {
  final String message;

  const ErrorSubjectPanelState({required this.message});

  @override
  List<Object> get props => [message];
}
