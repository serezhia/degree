part of 'students_page_cubit.dart';

class StudentsPageState extends Equatable {
  const StudentsPageState();

  @override
  List<Object> get props => [];
}

class InitialStudentsPageState extends StudentsPageState {}

class LoadingStudentsPageState extends StudentsPageState {}

class LoadedStudentsPageState extends StudentsPageState {
  final List<Student> students;

  const LoadedStudentsPageState({required this.students});

  @override
  List<Object> get props => [students];
}

class ErrorStudentsPageState extends StudentsPageState {
  final String message;

  const ErrorStudentsPageState({required this.message});

  @override
  List<Object> get props => [message];
}
