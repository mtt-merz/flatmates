// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mate _$MateFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['userId', 'name'],
    requiredKeys: const ['userId', 'name'],
  );
  return Mate._(
    json['userId'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$MateToJson(Mate instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
    };
