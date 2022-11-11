part of 'user_page_cubit.dart';

abstract class UserPageState extends Equatable {
  const UserPageState();

  @override
  List<Object> get props => [];
}

class InitialUserPageState extends UserPageState {}

class TeacherPageState extends UserPageState {}

class StudentPageState extends UserPageState {}
