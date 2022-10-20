import 'package:schedule_service/schedule_service.dart';

class Group {
  final int id;
  final int idSpeciality;
  final String name;
  final int course;
  final List<Subject>? subjects;

  Group(
      {required this.id,
      required this.idSpeciality,
      required this.name,
      required this.course,
      this.subjects});
}
