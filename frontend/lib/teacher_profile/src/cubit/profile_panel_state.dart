part of 'profile_panel_cubit.dart';

abstract class ProfilePanelState extends Equatable {
  const ProfilePanelState();

  @override
  List<Object> get props => [];
}

class InitialProfilePanelState extends ProfilePanelState {}

class LoadingProfilePanelState extends ProfilePanelState {}

class LoadedProfilePanelState extends ProfilePanelState {
  const LoadedProfilePanelState();
}

class ErrorProfilePanelState extends ProfilePanelState {}
