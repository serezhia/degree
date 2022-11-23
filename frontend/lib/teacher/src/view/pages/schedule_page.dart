import '../../../teacher.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: const [
              Text('переключался недель'),
              SizedBox(
                width: 10,
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
