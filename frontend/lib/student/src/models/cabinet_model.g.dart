// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cabinet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cabinet _$CabinetFromJson(Map<String, dynamic> json) => Cabinet(
      id: json['id'] as int,
      number: json['number'] as int,
      adress: json['adress'] as String?,
      floor: json['floor'] as int?,
      seats: json['seats'] as int?,
    );

Map<String, dynamic> _$CabinetToJson(Cabinet instance) => <String, dynamic>{
      'id': instance.id,
      'adress': instance.adress,
      'floor': instance.floor,
      'number': instance.number,
      'seats': instance.seats,
    };
