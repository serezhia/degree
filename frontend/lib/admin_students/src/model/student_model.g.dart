// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      studentId: json['studentId'] as int,
      firstName: json['firstName'] as String,
      secondName: json['secondName'] as String,
      group: Group.fromJson(json['group'] as Map<String, dynamic>),
      subgroup: Subgroup.fromJson(json['subgroup'] as Map<String, dynamic>),
      userId: json['userId'] as int?,
      middleName: json['middleName'] as String?,
      registrationCode: json['registrationCode'] as int?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'secondName': instance.secondName,
      'middleName': instance.middleName,
      'registrationCode': instance.registrationCode,
      'studentId': instance.studentId,
      'group': instance.group,
      'subgroup': instance.subgroup,
    };
