import 'package:degree_app/teacher/src/view/pages/task_page.dart';

import '../../../student.dart';

class PageBuilder extends StatelessWidget {
  const PageBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          return const Center(
            child: Text('Page not found'),
          );
        },
      );
}
