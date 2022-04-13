// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mate _$MateFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['name', 'surname', 'userId', 'colorValue'],
    requiredKeys: const ['name', 'userId', 'colorValue'],
  );
  return Mate._(
    json['userId'] as String,
    json['name'] as String,
    json['surname'] as String?,
    json['colorValue'] as int,
  );
}

Map<String, dynamic> _$MateToJson(Mate instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'userId': instance.userId,
      'colorValue': instance.colorValue,
    };
