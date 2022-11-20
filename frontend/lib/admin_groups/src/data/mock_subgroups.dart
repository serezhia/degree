import '../../admin_groups.dart';

List<Subgroup> subgroups = [];

List<Subgroup> addSubgroups() {
  final subgroups = <Subgroup>[];
  for (var i = 0; i < groupNames.length; i++) {
    for (var j = 1; j <= 4; j++) {
      subgroups
        ..add(Subgroup(id: i * 4, name: '${groupNames[i]}-${j}1/1'))
        ..add(Subgroup(id: i * 4 + 1, name: '${groupNames[i]}-${j}1/2'));
    }
  }

  return subgroups;
}
