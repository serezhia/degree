import 'package:degree_app/admin/cubit/page_cubit.dart';
import 'package:degree_app/admin/view/pages/entity_page.dart';
import 'package:degree_app/admin/view/pages/schedule_page.dart';
import 'package:degree_app/admin/view/pages/users_page.dart';
import 'package:degree_app/degree_ui/degree_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageBuilder extends StatelessWidget {
  const PageBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          if (state is UsersPageState) {
            return const UsersPage();
          } else if (state is EntityPageState) {
            return const EntityPage();
          } else if (state is SchedulePageState) {
            return const SchedulePage();
          } else {
            return Container();
          }
        },
      );
}
