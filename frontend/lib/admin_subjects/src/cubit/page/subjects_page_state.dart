part of 'subjects_page_cubit.dart';

class SubjectsPageState extends Equatable {
  const SubjectsPageState();

  @override
  List<Object> get props => [];
}

class InitialSubjectsPageState extends SubjectsPageState {}

class LoadingSubjectsPageState extends SubjectsPageState {}

class LoadedSubjectsPageState extends SubjectsPageState {
  final List<Subject> subjects;

  const LoadedSubjectsPageState({required this.subjects});

  @override
  List<Object> get props => [subjects];
}

class ErrorSubjectsPageState extends SubjectsPageState {
  final String message;

  const ErrorSubjectsPageState({required this.message});

  @override
  List<Object> get props => [message];
}
