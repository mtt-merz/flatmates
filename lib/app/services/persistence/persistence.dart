import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatmates/app/repositories/template/models/persistence_event.dart';
import 'package:flatmates/app/models/template/serializable_model.dart';
import 'package:logging/logging.dart' show Logger;

/// Get the [StoreRef] instance relative to the [key] param
CollectionReference _collection(String key) => FirebaseFirestore.instance.collection(key);

class Persistence {
  Logger get logger => Logger(runtimeType.toString());

  static Persistence get instance => _instance ??= Persistence._();
  static Persistence? _instance;

  /// Free all resources
  static void dispose() {
    if (_instance == null) return;
  }

  Persistence._();

  Stream<Map<String, dynamic>> getObjectStream(String key, String id) => _collection(key)
          .doc(id)
          .snapshots()
          .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
        final data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) sink.addError('Error received on getObjectStream');
        sink.add(data!);
      }));

  Stream<PersistenceEvent> getQueryStream(PersistenceQuery query) =>
      query.toFirestoreQuery
          .snapshots()
          .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
        final key = query.key;
        for (var change in snapshot.docChanges)
          switch (change.type) {
            case DocumentChangeType.added:
              // A new record has been ADDED
              sink.add(PersistenceEvent.insert(
                collection: key,
                recordId: change.doc.id,
                record: change.doc.data() as Map<String, dynamic>,
              ));
              break;
            case DocumentChangeType.modified:
              // A record has been UPDATED
              sink.add(PersistenceEvent.update(
                collection: key,
                recordId: change.doc.id,
                record: change.doc.data() as Map<String, dynamic>,
              ));
              break;
            case DocumentChangeType.removed:
              // A record has been DELETED
              sink.add(PersistenceEvent.delete(
                collection: key,
                recordId: change.doc.id,
                record: change.doc.data() as Map<String, dynamic>,
              ));
              break;
          }
      }));

  /// Store the json [json] into the DB.
  /// The table is inferred through the [key] param.
  Future<bool> insertJson(String key, String id, Map<String, dynamic> json) {
    json.remove('id');
    return _collection(key).add(json).then((value) => true).onError((error, stackTrace) {
      logger.severe('Error on insert record $id in \'$key\'', error, stackTrace);
      return false;
    });
  }

  /// Store [object] into the DB.
  /// The table is inferred through the [key] param.
  Future<bool> insert(String key, SerializableModel object) =>
      insertJson(key, object.id, object.toJson());

  /// Update the record with id [id]
  /// The table is inferred through the [key] param
  Future<bool> updateJson(String key, String id, Map<String, dynamic> json) {
    json.remove('id');
    return _collection(key)
        .doc(id)
        .set(json)
        .then((_) => true)
        .onError((error, stackTrace) {
      logger.severe('Error on update record $id in \'$key\'', error, stackTrace);
      return false;
    });
  }

  /// Update a [SerializableModel] instance.
  /// The table is inferred through the [key] param.
  Future<bool> update(String key, SerializableModel object) =>
      updateJson(key, object.id, object.toJson());

  /// Update the record with id [id] using the [update] function.
  /// The table is inferred through the [key] param.
  Future<bool> functionalUpdate(String key, String id,
      Map<String, dynamic> Function(Map<String, dynamic>) update) async {
    var record = await get(key, id);
    assert(record != null);

    return await updateJson(key, id, update(record!));
  }

  /// Remove the record with id [id].
  /// The table is inferred through the [key] param.
  Future<bool> removeFromId(String key, String id) =>
      _collection(key).doc(id).delete().then((_) => true).onError((error, stackTrace) {
        logger.severe('Unable to remove record $id in \'$key\'', error, stackTrace);
        return false;
      });

  /// Remove a [SerializableModel] instance.
  /// The table is inferred through the [key] param.
  Future<bool> remove(String key, SerializableModel object) =>
      removeFromId(key, object.id);

  /// Remove all [SerializableModel] instances that satisfy the predicate.
  /// The table is inferred through the [key] param.
  // Future<void> removeWhere(
  //         String key, bool Function(Map<String, dynamic>) predicate) async =>
  //     await _store(key).delete(_db,
  //         finder: Finder(
  //           filter: Filter.custom((record) => predicate(record.value)),
  //         ));

  /// =================
  /// ==== QUERIES ====
  /// =================

  /// Return the record with id [id].
  /// The table is inferred through the [key] param.
  Future<Map<String, dynamic>?> get(String key, String id) =>
      _collection(key).doc(id).get().then((result) {
        final data = result.data() as Map<String, dynamic>?;
        return data?..['id'] = id;
      }).onError((error, stackTrace) {
        logger.severe('Unable to fetch record $id from \'$key\'', error, stackTrace);
        return null;
      });

  /// Return all records that satisfies the [query].
  /// The table is inferred through the [key] param.
  Future<List<Map<String, dynamic>>> getQuery(String key, PersistenceQuery query) =>
      query.toFirestoreQuery
          .get()
          .then((result) => result.docs.map((element) {
                final data = element.data() as Map<String, dynamic>;
                data['id'] = element.id;
                return data;
              }).toList())
          .onError((error, stackTrace) {
        logger.severe('Unable to fetch records from \'$key\'', error, stackTrace);
        return [];
      });
}

/// Wrapper for the [Query] class
class PersistenceQuery {
  final String key;
  final Query _query;

  Query get toFirestoreQuery => _query;

  PersistenceQuery(this.key) : _query = _collection(key);

  PersistenceQuery._(this.key, this._query);

  PersistenceQuery isEqualTo({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, isEqualTo: value));

  PersistenceQuery isNotEqualTo({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, isNotEqualTo: value));

  PersistenceQuery isLessThan({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, isLessThan: value));

  PersistenceQuery isLessThanOrEqualTo({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, isLessThanOrEqualTo: value));

  PersistenceQuery isGreaterThan({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, isGreaterThan: value));

  PersistenceQuery isGreaterThanOrEqualTo(
          {required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, isGreaterThanOrEqualTo: value));

  PersistenceQuery arrayContains({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, arrayContains: value));

  PersistenceQuery arrayContainsAny(
          {required String field, required List<Object> value}) =>
      PersistenceQuery._(key, _query.where(field, arrayContainsAny: value));

  PersistenceQuery whereIn({required String field, required List<Object> value}) =>
      PersistenceQuery._(key, _query.where(field, whereIn: value));

  PersistenceQuery whereNotIn({required String field, required List<Object> value}) =>
      PersistenceQuery._(key, _query.where(field, whereNotIn: value));

  PersistenceQuery isNull({required String field, required bool isNull}) =>
      PersistenceQuery._(key, _query.where(field, isNull: isNull));
}
