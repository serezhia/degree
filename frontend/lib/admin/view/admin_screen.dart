import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin/cubit/page_cubit.dart';
import 'package:degree_app/admin/view/builders/action_panel_builder.dart';
import 'package:degree_app/admin/view/builders/page_builder.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreenProvider extends StatelessWidget {
  const AdminScreenProvider({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ActionPanelCubit()),
          BlocProvider(create: (context) => PageCubit()),
        ],
        child: ChangeNotifierProvider(
          create: (_) => SideBarState(),
          child: const AdminScreen(),
        ),
      );
}

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) => ScaffoldDegree(
        actionPanelIsActive:
            context.read<ActionPanelCubit>().actionPanelIsActive(
                  context.watch<ActionPanelCubit>().state,
                ),
        sideBar: SideBarDegree(
          items: const [
            SideBarItem(
              icon: Icons.group_outlined,
              title: 'Пользователи',
            ),
            SideBarItem(
              icon: Icons.groups_outlined,
              title: 'Группы',
            ),
            SideBarItem(
              icon: Icons.task_outlined,
              title: 'Задачи',
            ),
            SideBarItem(
              icon: Icons.inventory_2_outlined,
              title: 'Файлы',
            ),
          ],
          currentIndex: context.watch<PageCubit>().state.props[0] as int,
          onTapItem: (index) => context.read<PageCubit>().togglePage(index),
          leading: const SideBarLeading(
            pathLogo: 'assets/logo/logo.svg',
            title: 'Админ',
          ),
          onTapLeading: context.read<SideBarState>().toggle,
          isExpanded: context.watch<SideBarState>().isExpanded,
        ),
        actionPanel: const ActionPanelBuilder(),
        appBar: AppBarDegree(
          title: context.watch<PageCubit>().state.props[1] as String,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () =>
                    context.read<ActionPanelCubit>().toggleNotificationPanel(
                          context.read<ActionPanelCubit>().state,
                        ),
                child: const Icon(
                  Icons.notifications,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.read<ActionPanelCubit>().toggleProfilePanel(
                    context.read<ActionPanelCubit>().state,
                  ),
              child: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 30,
              ),
            )
          ],
        ),
        body: const PageBuilder(),
      );
}

class SideBarState extends ChangeNotifier {
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void toggle() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
