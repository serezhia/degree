import 'package:schedule_service/schedule_service.dart';

abstract class CabinetRepository {
  Future<bool> existsCabinet(
      {int? idCabinet, String? adress, int? floor, int? number});

  Future<Cabinet> insertCabinet(
      String adress, int floor, int number, int seats);

  Future<Cabinet> updateCabinet(Cabinet cabinet);

  Future<Cabinet> getCabinet(int idCabinet);

  Future<List<Cabinet>> getAllCabinets();

  Future<void> deleteCabinet(int idCabinet);

  Future<List<Cabinet>> getCabinetsBySubject(int idSubject);

  Future<Subject> addSubjectToCabinet(int idCabinet, int idSubject);

  Future<void> deleteSubjectFromCabinet(int idCabinet, int idSubject);

  Future<bool> existsCabinetsSubject(int idCabinet, int idSubject);

  Future<List<Subject>> getSubjectsByCabinet(int idCabinet);
}
