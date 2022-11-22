import 'package:degree_app/teacher_schedule/src/view/page/lesson_page.dart';
import 'package:degree_app/teacher_schedule/teacher_schedule.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Text('переключался недель'),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(child: LessonsList()),
        ],
      );
}
