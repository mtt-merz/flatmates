// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerializableModel _$SerializableModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return SerializableModel(
    json['id'] as String,
  );
}

Map<String, dynamic> _$SerializableModelToJson(SerializableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ExtendedSerializableModel _$ExtendedSerializableModelFromJson(
    Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'createdAt'],
  );
  return ExtendedSerializableModel(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['updatedAt'] as String),
  );
}

Map<String, dynamic> _$ExtendedSerializableModelToJson(
        ExtendedSerializableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
