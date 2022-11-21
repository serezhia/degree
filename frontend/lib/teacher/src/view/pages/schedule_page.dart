import 'package:degree_app/admin/admin.dart';
import 'package:degree_app/admin/cubit/action_panel_cubit.dart';
import 'package:degree_app/admin/cubit/pages/schedule/schedule_page_cubit.dart';
import 'package:degree_app/admin_schedule/src/cubit/action_panel/lesson_panel_cubit.dart';
import 'package:degree_app/admin_schedule/src/cubit/page/schedules_page_cubit.dart';
import 'package:degree_app/admin_schedule/src/view/page/schedule_page.dart';
import 'package:degree_app/degree_ui/date_time_picker/date_time_picker_degree.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              DateTimePickerDegree(
                currentDate: context.watch<SchedulePageCubit>().currentDate,
                currentDateTimeRange:
                    context.watch<SchedulePageCubit>().currentRange,
                onDateChanged: (date) {
                  context.read<SchedulePageCubit>().setDate(date);
                  context.read<SchedulesPageCubit>().refreshPage(date);
                },
                onTapBackDateRange: () {
                  context.read<SchedulePageCubit>().previosWeek();
                },
                onTapForwardDateRange:
                    context.read<SchedulePageCubit>().nextWeek,
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  context.read<ActionPanelCubit>().openLessonPanel();
                  context.read<LessonPanelCubit>().openAddPanel();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ScheduleList(),
        ],
      );
}
