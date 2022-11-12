part of 'groups_page_cubit.dart';

class GroupsPageState extends Equatable {
  const GroupsPageState();

  @override
  List<Object> get props => [];
}

class InitialGroupsPageState extends GroupsPageState {}

class LoadingGroupsPageState extends GroupsPageState {}

class LoadedGroupsPageState extends GroupsPageState {
  final List<Group> groups;

  const LoadedGroupsPageState({required this.groups});

  @override
  List<Object> get props => [groups];
}

class ErrorGroupsPageState extends GroupsPageState {
  final String message;

  const ErrorGroupsPageState({required this.message});

  @override
  List<Object> get props => [message];
}
