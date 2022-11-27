// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:degree_app/admin_subjects/admin_subjects.dart';
import 'package:degree_app/dio_singletone.dart';

class MainSubjectRepository implements SubjectRepository {
  @override
  Future<Subject> createSubject(String name) async {
    try {
      final response = await DioSingletone.dioMain.post<dynamic>(
        'schedule/subjects',
        queryParameters: <String, dynamic>{
          'name': name,
        },
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      return Subject(
        name: data['subject']!['name'] as String,
        id: data['subject']!['id'] as int,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteSubject(int id) async {
    try {
      await DioSingletone.dioMain.delete<dynamic>(
        'schedule/subjects/$id',
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Subject> getSubject(int id) async {
    try {
      final response = await DioSingletone.dioMain.get<dynamic>(
        'schedule/subjects/$id',
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      return Subject(
        name: data['subject']!['name'] as String,
        id: data['subject']!['id'] as int,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Subject>> getSubjectsList() async {
    try {
      final response = await DioSingletone.dioMain.get<dynamic>(
        'schedule/subjects/',
      );
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      final subjects = <Subject>[];
      for (final subject in data['subjects'] as List<dynamic>) {
        subjects.add(
          Subject(
            name: subject['name'] as String,
            id: subject['id'] as int,
          ),
        );
      }
      return subjects;
    } catch (e) {
      throw Exception(e);
    }
  }
}
