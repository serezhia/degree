import 'package:degree_app/admin_profile/admin_profile.dart';

class ProfileActionPanel extends StatelessWidget {
  const ProfileActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProfilePanelCubit, ProfilePanelState>(
        builder: (context, state) {
          if (state is LoadedProfilePanelState) {
            return const LoadedProfileActionPanel();
          } else {
            return const LoadingProfileActionPanel();
          }
        },
      );
}
