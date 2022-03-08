// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['id', 'name', 'addresses', 'start', 'end', 'done'],
    requiredKeys: const ['id', 'name', 'addresses', 'start', 'done'],
  );
  return Task._(
    json['id'] as String,
    json['name'] as String,
    (json['addresses'] as List<dynamic>).map((e) => e as String).toList(),
    DateTime.parse(json['start'] as String),
    json['end'] == null ? null : DateTime.parse(json['end'] as String),
    json['done'] as bool,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'addresses': instance.addresses,
      'start': instance.start.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'done': instance.done,
    };
