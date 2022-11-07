import 'package:degree_app/degree_ui/degree_ui.dart';

class ActionPanelWidegt extends StatelessWidget {
  const ActionPanelWidegt({
    super.key,
    required this.leading,
    required this.title,
    required this.body,
    this.actions,
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFFFFFFFF),
          height: 60,
          child: Row(
            children: [
              ActionPanelItemWidget(
                icon: leading.icon,
                onTap: leading.onTap,
              ),
              const SizedBox(width: 25),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (actions != null) ..._createActionPanelItemWidget(),
            ],
          ),
        ),
        Expanded(child: body),
      ],
    );
  }
}

class ActionPanel {
  ActionPanel({
    required this.title,
    required this.body,
    required this.leading,
    this.actions,
  });

  final String title;
  final List<ActionPanelItem>? actions;
  final Widget body;
  final ActionPanelItem leading;
}

class ActionPanelItemWidget extends StatelessWidget {
  const ActionPanelItemWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
}

class ActionPanelItem {
  ActionPanelItem({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;
}
