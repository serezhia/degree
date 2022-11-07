import 'package:degree_app/degree_ui/degree_ui.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SideBarState()),
        ChangeNotifierProvider(create: (_) => ActionPanelState()),
      ],
      child: const MainAdminScreen(),
    );
  }
}

class MainAdminScreen extends StatelessWidget {
  const MainAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDegree(
      sideBar: SideBarDegree(
        items: const [
          SideBarItem(
            icon: Icons.home,
            title: 'Пользователи',
          ),
          SideBarItem(
            icon: Icons.person,
            title: 'Пользователи',
          ),
          SideBarItem(
            icon: Icons.settings,
            title: 'Настройки',
          ),
        ],
        currentIndex: context.watch<SideBarState>().currentIndex,
        onTapItem: (index) => context.read<SideBarState>().setIndex(index),
        leading: const SideBarLeading(
          pathLogo: 'assets/logo/logo.svg',
          title: 'Админ',
        ),
        onTapLeading: context.read<SideBarState>().toggle,
        isExpanded: context.watch<SideBarState>().isExpanded,
      ),
      body: Container(
        height: 100000,
        color: Colors.red,
      ),
      isScrollableBody: true,
      actionPanel: context.watch<ActionPanelState>().isExpanded
          ? ActionPanel(
              title: 'Test action panel',
              leading: ActionPanelItem(
                icon: Icons.arrow_back,
                onTap: () {
                  context.read<ActionPanelState>().toggle();
                },
              ),
              body: Container(),
              actions: [
                ActionPanelItem(
                  icon: Icons.add,
                  onTap: () {},
                ),
                ActionPanelItem(
                  icon: Icons.delete,
                  onTap: () {},
                ),
              ],
            )
          : null,
      appBar: AppBarDegree(
        title: 'Test',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.read<ActionPanelState>().toggle();
            },
          ),
        ],
      ),
    );
  }
}

class ActionPanelState extends ChangeNotifier {
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void toggle() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}

class SideBarState extends ChangeNotifier {
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggle() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
