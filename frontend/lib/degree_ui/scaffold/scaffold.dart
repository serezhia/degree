import 'package:degree_app/degree_ui/degree_ui.dart';

class ScaffoldDegree extends StatelessWidget {
  const ScaffoldDegree({
    required this.sideBar,
    required this.body,
    required this.appBar,
    required this.actionPanelIsActive,
    required this.bottomBar,
    this.actionPanel,
    this.isScrollableBody = false,
    super.key,
  });

  final Widget body;
  final AppBarDegree appBar;
  final bool actionPanelIsActive;
  final Widget? actionPanel;
  final SideBarDegree sideBar;
  final bool isScrollableBody;
  final BottomBarDegree bottomBar;

  @override
  Widget build(BuildContext context) => MultiProvider(
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
                actionPanel: actionPanel,
                appBar: appBar,
                isScrollableBody: isScrollableBody,
                actionPanelIsActive: actionPanelIsActive,
              );
            } else if (constaints.maxWidth > 1000) {
              return LaptopCustomScreen(
                sideBar: sideBar,
                body: body,
                actionPanel: actionPanelIsActive ? actionPanel : null,
                appBar: appBar,
                isScrollableBody: isScrollableBody,
                actionPanelIsActive: actionPanelIsActive,
              );
            } else if (constaints.maxWidth > 700) {
              return TabletCustomScreen(
                sideBar: sideBar,
                body: body,
                actionPanel: actionPanelIsActive ? actionPanel : null,
                appBar: appBar,
                isScrollableBody: isScrollableBody,
                actionPanelIsActive: actionPanelIsActive,
              );
            } else {
              return MobileCustomScreen(
                sideBar: sideBar,
                body: body,
                actionPanel: actionPanelIsActive ? actionPanel : null,
                appBar: appBar,
                bottomBar: bottomBar,
                isScrollableBody: isScrollableBody,
                actionPanelIsActive: actionPanelIsActive,
              );
            }
          },
        ),
      );
}

class DesktopCustomScreen extends StatelessWidget {
  const DesktopCustomScreen({
    required this.sideBar,
    required this.body,
    required this.isScrollableBody,
    required this.actionPanelIsActive,
    this.actionPanel,
    this.appBar,
    super.key,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final Widget? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;
  final bool actionPanelIsActive;

  @override
  Widget build(BuildContext context) => Scaffold(
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
                                      padding: const EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 25,
                                      ),
                                      child: body,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 25,
                                      top: 25,
                                    ),
                                    child: body,
                                  ),
                          ),
                          if (actionPanelIsActive == true)
                            Padding(
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

class LaptopCustomScreen extends StatelessWidget {
  const LaptopCustomScreen({
    required this.sideBar,
    required this.body,
    required this.isScrollableBody,
    required this.actionPanelIsActive,
    this.actionPanel,
    this.appBar,
    super.key,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final Widget? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;
  final bool actionPanelIsActive;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: Row(
          children: [
            if (MediaQuery.of(context).size.width < 1100 && actionPanelIsActive)
              sideBar.copyWith(isExpanded: false)
            else
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
                                      padding: const EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        top: 25,
                                      ),
                                      child: body,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 25,
                                      top: 25,
                                    ),
                                    child: body,
                                  ),
                          ),
                          if (actionPanelIsActive == true)
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

class TabletCustomScreen extends StatelessWidget {
  const TabletCustomScreen({
    required this.sideBar,
    required this.body,
    required this.isScrollableBody,
    required this.actionPanelIsActive,
    this.actionPanel,
    this.appBar,
    super.key,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final Widget? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;
  final bool actionPanelIsActive;

  @override
  Widget build(BuildContext context) => Scaffold(
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
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 25,
                                ),
                                child: body,
                              ),
                            )
                          : ColoredBox(
                              color: const Color(0xFFFAFAFA),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 25,
                                ),
                                child: body,
                              ),
                            ),
                    ),
                  if (actionPanelIsActive == true)
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

class MobileCustomScreen extends StatelessWidget {
  const MobileCustomScreen({
    required this.isScrollableBody,
    required this.actionPanelIsActive,
    required this.sideBar,
    required this.body,
    required this.bottomBar,
    this.actionPanel,
    this.appBar,
    super.key,
  });

  final SideBarDegree sideBar;
  final Widget body;
  final Widget? actionPanel;
  final AppBarDegree? appBar;
  final bool isScrollableBody;
  final bool actionPanelIsActive;
  final BottomBarDegree bottomBar;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: actionPanel == null ? bottomBar : null,
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: actionPanel == null ? appBar : null,
        body: (actionPanelIsActive == false)
            ? isScrollableBody
                ? SingleChildScrollView(
                    key: context.watch<StateScroll>().key,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 25,
                      ),
                      child: body,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 25,
                    ),
                    child: body,
                  )
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).padding.top,
                    color: Colors.white,
                  ),
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

class StateScroll extends ChangeNotifier {
  final PageStorageKey<String> key = const PageStorageKey('scroll');
}

class ActionState extends ChangeNotifier {
  final PageStorageKey<String> key = const PageStorageKey('action');
}
