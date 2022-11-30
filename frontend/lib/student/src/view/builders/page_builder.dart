import 'package:degree_app/student/src/view/pages/schedule_page.dart';
import 'package:degree_app/student/src/view/pages/task_page.dart';

import '../../../student.dart';

class PageBuilder extends StatelessWidget {
  const PageBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          if (state is SchedulePageState) {
            return const SchedulePage();
          } else if (state is TaskPageState) {
            return const TaskPage();
          } else {
            return const Center(
              child: Text('Page not found'),
            );
          }
        },
      );
}
