import '../../admin_groups.dart';

part 'group_model.g.dart';

@JsonSerializable()
class Group {
  final int id;
  final String name;
  final Speciality speciality;
  final int course;
  final List<Subgroup>? subgroups;

  Group({
    required this.id,
    required this.name,
    required this.speciality,
    required this.course,
    required this.subgroups,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
