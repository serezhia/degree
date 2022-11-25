import 'package:degree_app/teacher_task/src/data/mock_tags.dart';
import 'package:degree_app/teacher_task/teacher_task.dart';

final mockListTasks = <Task>[
  Task(
    id: 0,
    subject: mockSubjectList.first,
    teacher: mockUserList.firstWhere((user) => user is Teacher) as Teacher,
    content: 'такое то задание, такое то управжение траляля',
    deadLineType: DeadLineType.date,
    deadLineDate: DateTime.now(),
    tags: [mockListTagsTask.first],
    group: mockGroupList.first,
  ),
  Task(
    id: 2,
    subject: mockSubjectList.first,
    teacher: mockUserList.firstWhere((user) => user is Teacher) as Teacher,
    content: 'такое то задание, такое то управжение траляля',
    deadLineType: DeadLineType.date,
    deadLineDate: DateTime.now(),
    tags: [mockListTagsTask[1]],
    group: mockGroupList[1],
  )
];
