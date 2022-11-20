import '../../admin_groups.dart';

final groupNames = [
  'ИСиТ',
  'БУАА',
  'МЕН',
  'МАР',
  'ЭКО',
  'ПРА',
  'ПСИ',
];

List<Group> groups = <Group>[];

List<Group> addGroups() {
  final groups = <Group>[];
  for (var i = 0; i < groupNames.length; i++) {
    for (var j = 1; j <= 4; j++) {
      groups.add(
        Group(
          id: i * 4 + j,
          name: '${groupNames[i]}-${j}1',
          speciality: specialities[i],
          course: j,
          subgroups: [
            Subgroup(id: i * 4, name: '${groupNames[i]}-${j}1/1'),
            Subgroup(id: i * 4 + 1, name: '${groupNames[i]}-${j}1/2'),
          ],
        ),
      );
    }
  }
  return groups;
}
