// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flat _$FlatFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'createdAt', 'name', 'mates', 'commonSpaces'],
  );
  return Flat._(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['updatedAt'] as String),
    json['name'] as String?,
    (json['mates'] as List<dynamic>).map((e) => Mate.fromJson(e)).toList(),
    (json['commonSpaces'] as List<dynamic>?)
            ?.map((e) => CommonSpace.fromJson(e))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$FlatToJson(Flat instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'mates': instance.mates,
      'commonSpaces': instance.commonSpaces,
    };
