// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/admin_schedule/admin_schedule.dart';
import 'package:degree_app/dio_singletone.dart';

class MainLessonTypeRepository implements LessonTypeRepository {
  @override
  Future<LessonType> addLessonType(String name) async {
    final response = await DioSingletone.dioMain.post<String>(
      'schedule/lessons/type',
      queryParameters: <String, dynamic>{
        'name': name,
      },
    );
    final data = jsonDecode(response.data!) as Map<String, dynamic>;

    return LessonType(
      id: data['lesson']!['id'] as int,
      name: data['lesson']!['name'] as String,
    );
  }

  @override
  Future<void> deleteLessonType(int id) async {
    try {
      await DioSingletone.dioMain.delete<String>('schedule/lessons/type/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LessonType> getLessonType(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'schedule/lessons/type/$id',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      return LessonType(
        id: data['lessonType']!['id'] as int,
        name: data['lessonType']!['name'] as String,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LessonType>> getLessonTypes() async {
    try {
      final response = await DioSingletone.dioMain.get<String>(
        'schedule/lessons/type',
      );
      final data = jsonDecode(response.data!) as Map<String, dynamic>;
      final lessonTypes = <LessonType>[];
      for (final dynamic lessonType in data['lessonTypes']!) {
        lessonTypes.add(
          LessonType(
            id: lessonType['id'] as int,
            name: lessonType['name'] as String,
          ),
        );
      }
      return lessonTypes;
    } catch (e) {
      rethrow;
    }
  }
}
