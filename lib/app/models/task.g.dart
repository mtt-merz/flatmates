// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'addresses', 'start', 'done'],
  );
  return Task(
    name: json['name'] as String,
    addresses:
        (json['addresses'] as List<dynamic>).map((e) => e as String).toList(),
    start: DateTime.parse(json['start'] as String),
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
  )..done = json['done'] as bool;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'name': instance.name,
      'addresses': instance.addresses,
      'start': instance.start.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'done': instance.done,
    };
