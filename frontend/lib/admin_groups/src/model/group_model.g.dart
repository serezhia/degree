// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as int,
      name: json['name'] as String,
      speciality:
          Speciality.fromJson(json['speciality'] as Map<String, dynamic>),
      course: json['course'] as int,
      subgroups: (json['subgroups'] as List<dynamic>?)
          ?.map((e) => Subgroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'speciality': instance.speciality,
      'course': instance.course,
      'subgroups': instance.subgroups,
    };
