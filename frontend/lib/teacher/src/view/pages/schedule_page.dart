import 'package:degree_app/teacher/src/cubit/pages/schedule/schedule_page_cubit.dart';

import '../../../teacher.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              WeekPickerDegree(
                currentDateTimeRange:
                    context.watch<SchedulePageCubit>().currentRange,
                onTapBackDateRange: () {
                  context.read<SchedulePageCubit>().previosWeek();
                  context.read<SchedulesPageCubit>().refreshPage(
                        context.read<SchedulePageCubit>().currentRange,
                      );
                },
                onTapForwardDateRange: () {
                  context.read<SchedulePageCubit>().nextWeek();
                  
                  context.read<SchedulesPageCubit>().refreshPage(
                        context.read<SchedulePageCubit>().currentRange,
                      );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Expanded(child: LessonsList()),
        ],
      );
}
