// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chore _$ChoreFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['title', 'description', 'user'],
  );
  return Chore(
    title: json['title'] as String,
    description: json['description'] as String?,
    user: (json['user'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ChoreToJson(Chore instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'user': instance.user,
    };
