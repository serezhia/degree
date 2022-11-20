import '../../admin_subjects.dart';

List<String> namesSubject = <String>[
  'Английский язык',
  'Биология',
  'География',
  'Информатика',
  'История',
  'Литература',
  'Математика',
  'Обществознание',
  'Русский язык',
  'Физика',
  'Химия',
  'Экономика',
  'Физкультура',
  'Музыка',
  'Искусство',
  'Технология',
  'Дополнительные предметы',
];

List<Subject> subjects = <Subject>[
  for (int i = 0; i < namesSubject.length; i++)
    Subject(
      id: i,
      name: namesSubject[i],
    ),
];
