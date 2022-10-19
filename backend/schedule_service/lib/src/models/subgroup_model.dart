import 'package:schedule_service/schedule_service.dart';

class Subgroup {
  final int id;
  final String name;
  final List<Subject>? subjects;

  Subgroup({required this.id, required this.name, this.subjects});
}
