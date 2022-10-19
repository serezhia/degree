import 'package:schedule_service/schedule_service.dart';

class Cabinet {
  final int id;
  final String adress;
  final int floor;
  final int number;
  final int seats;
  final List<Subject>? subjects;

  Cabinet(
      {required this.id,
      required this.adress,
      required this.floor,
      required this.number,
      required this.seats,
      this.subjects});
}
