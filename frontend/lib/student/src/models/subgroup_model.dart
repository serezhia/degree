import '../../student.dart';

part 'subgroup_model.g.dart';

@JsonSerializable()
class Subgroup {
  final int id;
  final String name;

  Subgroup({
    required this.id,
    required this.name,
  });

  factory Subgroup.fromJson(Map<String, dynamic> json) =>
      _$SubgroupFromJson(json);
}
