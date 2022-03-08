// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flat _$FlatFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['id', 'name', 'mates', 'commonSpaces'],
    requiredKeys: const ['id', 'name', 'mates', 'commonSpaces'],
  );
  return Flat._(
    json['id'] as String,
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
      'name': instance.name,
      'mates': instance.mates.map((e) => e.toJson()).toList(),
      'commonSpaces': instance.commonSpaces.map((e) => e.toJson()).toList(),
    };
