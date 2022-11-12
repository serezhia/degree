import 'package:degree_app/admin_groups/admin_groups.dart';

class GroupActionPanel extends StatelessWidget {
  const GroupActionPanel();
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<GroupPanelCubit, GroupPanelState>(
        builder: (context, state) {
          if (state is InfoGroupPanelState) {
            return const InfoGroupActionPanel();
          } else if (state is AddGroupPanelState) {
            return const AddGroupActionPanel();
          } else if (state is EditGroupPanelState) {
            return const EditGroupActionPanel();
          } else {
            return const LoadingGroupActionPanel();
          }
        },
      );
}
