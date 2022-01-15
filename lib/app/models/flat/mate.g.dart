// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mate _$MateFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'createdAt', 'name', 'userId'],
  );
  return Mate._(
    json['id'],
    json['createdAt'],
    json['updatedAt'],
    json['name'] as String,
    json['userId'] as String?,
  );
}

Map<String, dynamic> _$MateToJson(Mate instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'userId': instance.userId,
    };
