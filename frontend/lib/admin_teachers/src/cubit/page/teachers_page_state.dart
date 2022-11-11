part of 'teachers_page_cubit.dart';

class TeachersPageState extends Equatable {
  const TeachersPageState();

  @override
  List<Object> get props => [];
}

class InitialTeachersPageState extends TeachersPageState {}

class LoadingTeachersPageState extends TeachersPageState {}

class LoadedTeachersPageState extends TeachersPageState {
  final List<Teacher> teachers;

  const LoadedTeachersPageState({required this.teachers});

  @override
  List<Object> get props => [teachers];
}

class ErrorTeachersPageState extends TeachersPageState {
  final String message;

  const ErrorTeachersPageState({required this.message});

  @override
  List<Object> get props => [message];
}
