import 'package:degree_app/admin_schedule/src/model/cabinet_model.dart';

abstract class CabinetRepository {
  Future<List<Cabinet>> getCabinets();

  Future<Cabinet> getCabinet(int id);

  Future<Cabinet> addCabinet(int number);

  Future<void> deleteCabinet(int id);
}
