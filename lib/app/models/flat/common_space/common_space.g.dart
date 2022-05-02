// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonSpace _$CommonSpaceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['name', 'colorValue', 'enabled'],
    requiredKeys: const ['name', 'colorValue', 'enabled'],
  );
  return CommonSpace._(
    json['name'] as String,
    json['colorValue'] as int,
    json['enabled'] as bool,
  );
}

Map<String, dynamic> _$CommonSpaceToJson(CommonSpace instance) =>
    <String, dynamic>{
      'name': instance.name,
      'colorValue': instance.colorValue,
      'enabled': instance.enabled,
    };
