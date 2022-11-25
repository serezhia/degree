import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FileDegree {
  final String id;
  final String name;
  final String url;
  final int size;
  final DateTime createdAt;

  FileDegree({
    required this.id,
    required this.name,
    required this.url,
    required this.size,
    required this.createdAt,
  });
}
