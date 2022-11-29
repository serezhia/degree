import 'package:degree_app/notification/notification.dart';
import 'package:degree_app/student/src/cubit/pages/schedule/schedule_page_cubit.dart';
import 'package:degree_app/student/src/data/main_student_data_source.dart';
import 'package:degree_app/student_profile/student_profile.dart';

class StudentScreenProvider extends StatelessWidget {
  const StudentScreenProvider({super.key});

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
            create: (context) => LessonPanelCubit(
              MainStudentDataSource(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfilePanelCubit(),
          ),
          BlocProvider(
            create: (context) => PageCubit(),
          ),
          BlocProvider(
            create: (context) => SchedulesPageCubit(
              MainStudentDataSource(),
            ),
          ),
          BlocProvider(
            create: (context) => SchedulePageCubit(),
          ),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SideBarState(),
            ),
          ],
          child: const StudentScreen(),
        ),
      );
}

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

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
          ],
          currentIndex: context.watch<PageCubit>().state.props[0] as int,
          onTapItem: (index) => context.read<PageCubit>().togglePage(index),
          leading: const SideBarLeading(
            pathLogo: 'assets/logo/logo.svg',
            title: 'Студент',
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
