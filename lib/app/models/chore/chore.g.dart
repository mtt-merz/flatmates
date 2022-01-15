// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chore _$ChoreFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'createdAt', 'title', 'description', 'user'],
  );
  return Chore._(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['updatedAt'] as String),
    json['title'] as String,
    json['description'] as String?,
    (json['user'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ChoreToJson(Chore instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'user': instance.user,
    };
