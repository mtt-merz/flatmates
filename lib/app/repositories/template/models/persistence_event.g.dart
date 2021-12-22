// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistence_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersistenceEvent _$PersistenceEventFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'collection', 'recordId', 'type'],
  );
  return PersistenceEvent._(
    json['id'] as String,
    json['collection'] as String,
    json['recordId'] as String,
    json['record'] as Map<String, dynamic>,
    $enumDecode(_$PersistenceEventTypeEnumMap, json['type']),
  );
}

Map<String, dynamic> _$PersistenceEventToJson(PersistenceEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collection': instance.collection,
      'recordId': instance.recordId,
      'type': _$PersistenceEventTypeEnumMap[instance.type],
      'record': instance.record,
    };

const _$PersistenceEventTypeEnumMap = {
  PersistenceEventType.insert: 'insert',
  PersistenceEventType.delete: 'delete',
  PersistenceEventType.update: 'update',
};
