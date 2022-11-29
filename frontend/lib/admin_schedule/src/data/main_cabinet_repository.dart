// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/admin_schedule/src/model/cabinet_model.dart';
import 'package:degree_app/admin_schedule/src/repository/cabinet_repository.dart';
import 'package:degree_app/dio_singletone.dart';

class MainCabinetRepository implements CabinetRepository {
  @override
  Future<Cabinet> addCabinet(int number) async {
    try {
      final response = await DioSingletone.dioMain.post<String>(
        'schedule/cabinets',
        queryParameters: <String, dynamic>{
          'number': number,
          'adress': '',
          'floor': -1,
          'seats': -1,
        },
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      return Cabinet(
        id: data['cabinet']!['id'] as int,
        number: data['cabinet']!['number'] as int,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCabinet(int id) {
    try {
      return DioSingletone.dioMain.delete<String>('schedule/cabinets/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Cabinet> getCabinet(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'schedule/cabinets/$id',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      return Cabinet(
        id: data['cabinet']!['id'] as int,
        number: int.parse(data['cabinet']!['number'] as String),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Cabinet>> getCabinets() async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'schedule/cabinets',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      final cabinets = <Cabinet>[];
      for (final dynamic cabinet in data['cabinets']!) {
        cabinets.add(
          Cabinet(
            id: cabinet['id'] as int,
            number: cabinet['number'] as int,
          ),
        );
      }
      return cabinets;
    } catch (e) {
      rethrow;
    }
  }
}
