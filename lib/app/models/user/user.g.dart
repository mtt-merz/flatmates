// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['id', 'isAnonymous', 'flatId'],
    requiredKeys: const ['id', 'isAnonymous'],
  );
  return User._(
    json['id'] as String,
    json['isAnonymous'] as bool,
    json['flatId'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'isAnonymous': instance.isAnonymous,
      'flatId': instance.flatId,
    };
