import '../../admin_schedule.dart';

part 'cabinet_model.g.dart';

@JsonSerializable()
class Cabinet {
  final int id;
  final String? adress;
  final int? floor;
  final int number;
  final int? seats;

  Cabinet({
    required this.id,
    required this.number,
    this.adress,
    this.floor,
    this.seats,
  });
  factory Cabinet.fromJson(Map<String, dynamic> json) =>
      _$CabinetFromJson(json);
}
