import 'package:degree_app/notification/notification.dart';
import 'package:degree_app/teacher/src/cubit/pages/schedule/schedule_page_cubit.dart';
import 'package:degree_app/teacher/src/cubit/pages/tasks/task_page_cubit.dart';
import 'package:degree_app/teacher_task/src/cubit/action_panel/task_panel_cubit.dart';
import 'package:degree_app/teacher_task/src/cubit/page/tasks_page_cubit.dart';
import 'package:degree_app/teacher_task/src/data/mock_task_repository.dart';

import '../../teacher.dart';

class TeacherScreenProvider extends StatelessWidget {
  const TeacherScreenProvider({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ActionPanelCubit(),
          ),
          BlocProvider(
            create: (context) => NotificationPanelCubit(
              MockNotificationRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfilePanelCubit(),
          ),
          BlocProvider(
            create: (context) => LessonPanelCubit(
              MockMainTeacherRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => TaskPanelCubit(
              MockTaskRepository(),
              MockMainTeacherRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => PageCubit(),
          ),
          BlocProvider(
            create: (context) => SchedulePageCubit(),
          ),
          BlocProvider(
            create: (context) => SchedulesPageCubit(
              MockMainTeacherRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => TaskPageCubit(),
          ),
          BlocProvider(
            create: (context) => TasksPageCubit(
              MockTaskRepository(),
            ),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SideBarState(),
            ),
          ],
          child: const TeacherScreen(),
        ),
      );
}

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) => ScaffoldDegree(
        actionPanelIsActive:
            context.read<ActionPanelCubit>().actionPanelIsActive(
                  context.watch<ActionPanelCubit>().state,
                ),
        sideBar: SideBarDegree(
          items: const [
            SideBarItem(
              icon: Icons.schedule_outlined,
              title: 'Расписание',
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
            title: 'Учитель',
          ),
          onTapLeading: context.read<SideBarState>().toggle,
          isExpanded: context.watch<SideBarState>().isExpanded,
        ),
        actionPanel: const ActionPanelBuilder(),
        appBar: AppBarDegree(
          title: context.watch<PageCubit>().state.props[1] as String,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.notifications,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<ActionPanelCubit>().openProfilePanel();
                context.read<ProfilePanelCubit>().loadProfile();
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                child: const CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30,
                ),
              ),
            )
          ],
        ),
        body: const PageBuilder(),
        bottomBar: BottomBarDegree(
          items: const [
            BottomBarItem(
              icon: Icons.schedule_outlined,
              title: 'Расписание',
            ),
            BottomBarItem(
              icon: Icons.task_outlined,
              title: 'Задачи',
            ),
            BottomBarItem(
              icon: Icons.inventory_2_outlined,
              title: 'Файлы',
            ),
          ],
          currentIndex: context.watch<PageCubit>().state.props[0] as int,
          onTapItem: (index) => context.read<PageCubit>().togglePage(index),
        ),
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
