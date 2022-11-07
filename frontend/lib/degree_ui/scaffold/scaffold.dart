import 'package:degree_app/degree_ui/degree_ui.dart';

class ScaffoldDegree extends StatelessWidget {
  const ScaffoldDegree({
    super.key,
    required this.sideBar,
    required this.body,
    required this.appBar,
    this.actionPanel,
    this.isScrollableBody = false,
  });

  final Widget body;
  final AppBarDegree appBar;
  final ActionPanel? actionPanel;
  final SideBarDegree sideBar;
  final bool isScrollableBody;

  ActionPanelWidegt _createActionPanel() {
    return ActionPanelWidegt(
      title: actionPanel!.title,
      leading: actionPanel!.leading,
      actions: actionPanel?.actions,
      body: actionPanel!.body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StateScroll(),
        ),
        ChangeNotifierProvider(
          create: (context) => ActionState(),
        )
      ],
      child: LayoutBuilder(
        builder: (context, constaints) {
          if (constaints.maxWidth > 1600) {
            return DesktopCustomScreen(
              sideBar: sideBar,
              body: body,
              actionPanel: actionPanel != null ? _createActionPanel() : null,
              appBar: appBar,
              isScrollableBody: isScrollableBody,
            );
          } else if (constaints.maxWidth > 1000) {
            return LaptopCustomScreen(
              sideBar: sideBar,
              body: body,
              actionPanel: actionPanel != null ? _createActionPanel() : null,
              appBar: appBar,
              isScrollableBody: isScrollableBody,
            );
          } else if (constaints.maxWidth > 700) {
            return TabletCustomScreen(
              sideBar: sideBar,
              body: body,
              actionPanel: actionPanel != null ? _createActionPanel() : null,
              appBar: appBar,
              isScrollableBody: isScrollableBody,
            );
          } else {
            return MobileCustomScreen(
              sideBar: sideBar,
              body: body,
              actionPanel: actionPanel != null ? _createActionPanel() : null,
              appBar: appBar,
              isScrollableBody: isScrollableBody,
            );
          }
        },
      ),
    );
  }
}

class DesktopCustomScreen extends StatelessWidget {
  const DesktopCustomScreen({
    super.key,
    required this.sideBar,
    required this.body,
    this.actionPanel,
    this.appBar,
    required this.isScrollableBody,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final ActionPanelWidegt? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Row(
        children: [
          sideBar,
          Expanded(
            child: Column(
              children: [
                if (appBar != null) appBar!,
                Expanded(
                  child: ColoredBox(
                    color: const Color(0xFFFAFAFA),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: isScrollableBody
                              ? SingleChildScrollView(
                                  key: context.watch<StateScroll>().key,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: body,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: body,
                                ),
                        ),
                        if (actionPanel != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 25,
                              top: 25,
                              bottom: 25,
                            ),
                            child: SizedBox(width: 425, child: actionPanel),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LaptopCustomScreen extends StatelessWidget {
  const LaptopCustomScreen({
    super.key,
    required this.sideBar,
    required this.body,
    this.actionPanel,
    this.appBar,
    required this.isScrollableBody,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final ActionPanelWidegt? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Row(
        children: [
          sideBar,
          Expanded(
            child: Column(
              children: [
                if (appBar != null) appBar!,
                Expanded(
                  child: ColoredBox(
                    color: const Color(0xFFFAFAFA),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: isScrollableBody
                              ? SingleChildScrollView(
                                  key: context.watch<StateScroll>().key,
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: body,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: body,
                                ),
                        ),
                        if (actionPanel != null)
                          Padding(
                            key: context.watch<ActionState>().key,
                            padding: const EdgeInsets.only(
                              right: 25,
                              top: 25,
                              bottom: 25,
                            ),
                            child: SizedBox(width: 400, child: actionPanel),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabletCustomScreen extends StatelessWidget {
  const TabletCustomScreen({
    super.key,
    required this.sideBar,
    required this.body,
    this.actionPanel,
    this.appBar,
    required this.isScrollableBody,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final ActionPanelWidegt? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Row(
        children: [
          sideBar.copyWith(
            isExpanded: false,
          ),
          Expanded(
            child: Column(
              children: [
                if (appBar != null) appBar!,
                if (actionPanel == null)
                  Expanded(
                    child: isScrollableBody
                        ? SingleChildScrollView(
                            key: context.watch<StateScroll>().key,
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: body,
                            ),
                          )
                        : Padding(
                            key: context.watch<ActionState>().key,
                            padding: const EdgeInsets.all(25),
                            child: body,
                          ),
                  ),
                if (actionPanel != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child:
                          ColoredBox(color: Colors.white, child: actionPanel),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MobileCustomScreen extends StatelessWidget {
  const MobileCustomScreen({
    super.key,
    required this.sideBar,
    required this.body,
    this.actionPanel,
    this.appBar,
    required this.isScrollableBody,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final ActionPanelWidegt? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: actionPanel == null ? appBar : null,
      body: (actionPanel == null)
          ? isScrollableBody
              ? SingleChildScrollView(
                  key: context.watch<StateScroll>().key,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: body,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(25),
                  child: body,
                )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    key: context.watch<ActionState>().key,
                    padding: EdgeInsets.zero,
                    child: actionPanel,
                  ),
                ),
              ],
            ),
    );
  }
}

class StateScroll extends ChangeNotifier {
  final PageStorageKey<String> key = const PageStorageKey('scroll');
}

class ActionState extends ChangeNotifier {
  final PageStorageKey<String> key = const PageStorageKey('action');
}
