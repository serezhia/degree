import 'package:degree_app/degree_ui/degree_ui.dart';

class ActionPanel extends StatelessWidget {
  const ActionPanel({
    required this.leading,
    required this.title,
    required this.body,
    this.actions,
    super.key,
  });
  final ActionPanelItem leading;
  final String title;
  final Widget body;
  final List<ActionPanelItem>? actions;

  List<ActionPanelItemWidget> _createActionPanelItemWidget() {
    final actionPanelItemWidgets = <ActionPanelItemWidget>[];
    for (var i = 0; i <= actions!.length - 1; i++) {
      actionPanelItemWidgets.add(
        ActionPanelItemWidget(
          icon: actions![i].icon,
          onTap: actions![i].onTap,
        ),
      );
    }
    return actionPanelItemWidgets;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border(
                bottom: BorderSide(color: Color(0xFFF4F4F5), width: 2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  ActionPanelItemWidget(
                    icon: leading.icon,
                    onTap: leading.onTap,
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (actions != null) ..._createActionPanelItemWidget(),
                ],
              ),
            ),
          ),
          Expanded(child: body),
        ],
      );
}

class ActionPanelItemWidget extends StatelessWidget {
  const ActionPanelItemWidget({
    required this.icon,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => MouseRegion(
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Icon(
              icon,
              size: 24,
              color: const Color(0xFF000000),
            ),
          ),
        ),
      );
}

class ActionPanelItem {
  ActionPanelItem({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;
}
