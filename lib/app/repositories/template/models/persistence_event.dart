// import 'package:flatmates/app/models/serializable_model.dart';
//
// part 'persistence_event.g.dart';
//
// @JsonSerializable(constructor: '_')
// class PersistenceEvent extends SerializableModel1 {
//   @JsonKey(required: true)
//   final String collection;
//
//   @JsonKey(required: true)
//   final String recordId;
//
//   @JsonKey(required: true)
//   final Map<String, dynamic> _record;
//
//   @JsonKey(required: true)
//   final PersistenceEventType type;
//
//   @JsonKey(ignore: true)
//   bool isStored;
//
//   PersistenceEvent.insert({
//     required this.collection,
//     required this.recordId,
//     required Map<String, dynamic> record,
//   })  : _record = record..['id'] = recordId,
//         type = PersistenceEventType.insert,
//         isStored = false,
//         super.init();
//
//   PersistenceEvent.update({
//     required this.collection,
//     required this.recordId,
//     required Map<String, dynamic> record,
//   })  : _record = record..['id'] = recordId,
//         type = PersistenceEventType.update,
//         isStored = false,
//         super.init();
//
//   PersistenceEvent.delete({
//     required this.collection,
//     required this.recordId,
//     required Map<String, dynamic> record,
//   })  : _record = record..['id'] = recordId,
//         type = PersistenceEventType.delete,
//         isStored = false,
//         super.init();
//
//   PersistenceEvent._(
//     String id,
//     this.collection,
//     this.recordId,
//     Map<String, dynamic> record,
//     this.type,
//   )   : _record = record,
//         isStored = true,
//         super(id);
//
//   @override
//   factory PersistenceEvent.fromJson(json) => _$PersistenceEventFromJson(json);
//
//   @override
//   Map<String, dynamic> toJson() => _$PersistenceEventToJson(this);
//
//   Map<String, dynamic> get record => _record;
//
//   @override
//   String toString() => '$type of $recordId';
// }
//
// enum PersistenceEventType { insert, delete, update }
