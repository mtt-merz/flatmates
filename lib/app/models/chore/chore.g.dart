// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chore _$ChoreFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['id', 'title', 'description', 'mateIds'],
    requiredKeys: const ['id', 'title', 'description', 'mateIds'],
  );
  return Chore._(
    json['id'] as String,
    json['title'] as String,
    json['description'] as String?,
    (json['mateIds'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ChoreToJson(Chore instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'mateIds': instance.mateIds,
    };
