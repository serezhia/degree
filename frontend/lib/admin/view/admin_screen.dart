import 'package:degree_app/admin/cubit/page_cubit.dart';
import 'package:degree_app/admin/cubit/pages/entities/entity_page_cubit.dart';
import 'package:degree_app/admin/cubit/pages/schedule/schedule_page_cubit.dart';
import 'package:degree_app/admin/cubit/pages/users/user_page_cubit.dart';
import 'package:degree_app/admin/view/builders/action_panel_builder.dart';
import 'package:degree_app/admin/view/builders/page_builder.dart';
import 'package:degree_app/admin/view/pages/users_page.dart';
import 'package:degree_app/admin_groups/admin_groups.dart';
import 'package:degree_app/admin_groups/src/data/mock_group_repository.dart';
import 'package:degree_app/admin_profile/admin_profile.dart';
import 'package:degree_app/admin_schedule/src/cubit/action_panel/lesson_panel_cubit.dart';
import 'package:degree_app/admin_schedule/src/cubit/page/schedules_page_cubit.dart';
import 'package:degree_app/admin_schedule/src/data/mock_lessons_repository.dart';
import 'package:degree_app/admin_students/admin_students.dart';
import 'package:degree_app/admin_subjects/src/data/main_subject_repository.dart';
import 'package:degree_app/admin_teachers/admin_teachers.dart';
import 'package:degree_app/admin_teachers/src/data/main_teacher_repository.dart';
import 'package:degree_app/notification/notification.dart';

class AdminScreenProvider extends StatelessWidget {
  const AdminScreenProvider({super.key});

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
            create: (context) => TeacherPanelCubit(
              MainTeacherRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => StudentPanelCubit(
              MockStudentRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => GroupPanelCubit(
              MockGroupRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => SubjectPanelCubit(
              MainSubjectRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => LessonPanelCubit(
              MockLessonRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => PageCubit(),
          ),
          BlocProvider(
            create: (context) => UserPageCubit(),
          ),
          BlocProvider(
            create: (context) => TeachersPageCubit(
              MainTeacherRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => StudentsPageCubit(
              MockStudentRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => EntityPageCubit(),
          ),
          BlocProvider(
            create: (context) => SubjectsPageCubit(
              MainSubjectRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => GroupsPageCubit(
              MockGroupRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => SchedulePageCubit(),
          ),
          BlocProvider(
            create: (context) => SchedulesPageCubit(
              MockLessonRepository(),
            ),
          )
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SideBarState(),
            ),
            ChangeNotifierProvider(create: (_) => UsersState()),
            ChangeNotifierProvider(create: (_) => EntitiesState()),
          ],
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
              title: 'Сущности',
            ),
            SideBarItem(
              icon: Icons.task_outlined,
              title: 'Задачи',
            ),
            SideBarItem(
              icon: Icons.inventory_2_outlined,
              title: 'Файлы',
            ),
            SideBarItem(
              icon: Icons.schedule_outlined,
              title: 'Расписание',
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  context.read<ActionPanelCubit>().openNotificationPanel();
                  context.read<NotificationPanelCubit>().loadNotifications();
                },
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
              icon: Icons.group_outlined,
              title: 'Пользователи',
            ),
            BottomBarItem(
              icon: Icons.groups_outlined,
              title: 'Сущности',
            ),
            BottomBarItem(
              icon: Icons.task_outlined,
              title: 'Задачи',
            ),
            BottomBarItem(
              icon: Icons.inventory_2_outlined,
              title: 'Файлы',
            ),
            BottomBarItem(
              icon: Icons.schedule_outlined,
              title: 'Расписание',
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
