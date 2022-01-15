// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'createdAt',
      'name',
      'addresses',
      'start',
      'done'
    ],
  );
  return Task._(
    json['id'] as String,
    DateTime.parse(json['createdAt'] as String),
    DateTime.parse(json['updatedAt'] as String),
    json['name'] as String,
    (json['addresses'] as List<dynamic>).map((e) => e as String).toList(),
    DateTime.parse(json['start'] as String),
    json['end'] == null ? null : DateTime.parse(json['end'] as String),
    json['done'] as bool,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'name': instance.name,
      'addresses': instance.addresses,
      'start': instance.start.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'done': instance.done,
    };
