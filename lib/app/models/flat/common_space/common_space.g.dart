// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonSpace _$CommonSpaceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'colorValue'],
  );
  return CommonSpace._(
    json['name'] as String,
    json['colorValue'] as int,
  );
}

Map<String, dynamic> _$CommonSpaceToJson(CommonSpace instance) =>
    <String, dynamic>{
      'name': instance.name,
      'colorValue': instance.colorValue,
    };
