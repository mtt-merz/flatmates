// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return User(
    json['id'] as String,
  )
    ..name = json['name'] as String
    ..flat = json['flat'] as String
    ..colorValue = json['colorValue'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flat': instance.flat,
      'colorValue': instance.colorValue,
    };
