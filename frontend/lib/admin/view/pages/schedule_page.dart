import 'package:degree_app/admin/admin.dart';
import 'package:degree_app/admin/cubit/pages/schedule/schedule_page_cubit.dart';
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
                },
                onTapBackDateRange: () {
                  context.read<SchedulePageCubit>().previosWeek();
                },
                onTapForwardDateRange:
                    context.read<SchedulePageCubit>().nextWeek,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
}
