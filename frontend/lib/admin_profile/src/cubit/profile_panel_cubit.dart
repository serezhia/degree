import '../../admin_profile.dart';

part 'profile_panel_state.dart';

class ProfilePanelCubit extends Cubit<ProfilePanelState> {
  ProfilePanelCubit() : super(InitialProfilePanelState());

  Future<void> loadProfile() async {
    emit(LoadingProfilePanelState());
    try {
      emit(const LoadedProfilePanelState());
    } catch (e) {
      emit(ErrorProfilePanelState());
    }
  }
}
