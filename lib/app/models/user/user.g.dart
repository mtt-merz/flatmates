// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'colorValue'],
  );
  return User._(
    json['id'] as String,
    json['flatId'] as String?,
    json['colorValue'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'flatId': instance.flatId,
      'colorValue': instance.colorValue,
    };
