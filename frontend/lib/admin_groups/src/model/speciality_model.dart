import '../../admin_groups.dart';

part 'speciality_model.g.dart';

@JsonSerializable()
class Speciality {
  final int id;
  final String name;

  Speciality({
    required this.id,
    required this.name,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) =>
      _$SpecialityFromJson(json);
}
