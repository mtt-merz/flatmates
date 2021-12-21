// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flat _$FlatFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'createdAt', 'name', 'owner'],
  );
  return Flat._(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['updatedAt'] as String),
    json['name'] as String,
    json['owner'] as String?,
    (json['mates'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  );
}

Map<String, dynamic> _$FlatToJson(Flat instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'owner': instance.owner,
      'mates': instance.mates,
    };
