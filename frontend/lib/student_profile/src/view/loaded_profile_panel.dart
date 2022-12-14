import 'package:degree_app/l10n/l10n.dart';

import '../../student_profile.dart';

class LoadedProfileActionPanel extends StatelessWidget {
  const LoadedProfileActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final actionPanelState = context.read<ActionPanelCubit>().state;
    return ActionPanel(
      leading: ActionPanelItem(
        icon: Icons.close,
        onTap: () {
          context.read<ActionPanelCubit>().closePanel(actionPanelState);
        },
      ),
      actions: [
        ActionPanelItem(
          icon: Icons.exit_to_app,
          onTap: () {
            context.read<AuthCubit>().logOut();
          },
        ),
      ],
      title: AppLocalizations.of(context).profileActionPanelTitle,
      body: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: const [
              ProfileInfo(),
              ProfileActions(),
            ],
          ),
        ),
      ),
    );
  }
}

/// HARDCODE
class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 75,
            backgroundColor: Colors.grey,
          ),
          const SizedBox(height: 20),
          Text(
            (context.read<AuthCubit>().state as AuthAutorized).user.username,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      );
}

class ProfileActions extends StatelessWidget {
  const ProfileActions({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).profileActionPanelLoginText,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('???????????? ???????????? "???????????????? ??????????"'),
                      ),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        (context.read<AuthCubit>().state as AuthAutorized)
                            .user
                            .username,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).profileActionPanelPasswordText,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.black,
                        content: Text('???????????? ???????????? "???????????????? ????????????"'),
                      ),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        AppLocalizations.of(context)
                            .profileActionPanelChangeText,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('???????????? ???????????? "??????????????????"'),
                      ),
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        AppLocalizations.of(context)
                            .profileActionPanelSettingsText,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
