import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatmates/app/models/serializable_model.dart';
import 'package:logging/logging.dart' show Logger;

/// Get the [StoreRef] instance relative to the [key] param
CollectionReference _collection(String key) => FirebaseFirestore.instance.collection(key);

class Persistence {
  Logger get logger => Logger(runtimeType.toString());

  static Persistence get instance => _instance ??= Persistence._();
  static Persistence? _instance;

  Persistence._();

  /// Generate an unique ID for a generic collection.
  String generateId(String key) => _collection(key).doc().id;

  /// Store [object] into the DB.
  /// The table is inferred through the [key] param.
  Future<bool> insert(SerializableModel object) =>
      insertJson(object.key, object.id, object.toJson());

  /// Store the json [json] into the DB.
  /// The table is inferred through the [key] param.
  Future<bool> insertJson(String key, String id, Map<String, dynamic> json) => _collection(key)
          .doc(id)
          .set(json
            ..remove('id')
            ..remove('key'))
          .then((value) => true)
          .onError((error, stackTrace) {
        logger.severe('Error on insert record $id in \'$key\'', error, stackTrace);
        return false;
      });

  /// Update a [SerializableModel1] instance.
  /// The table is inferred through the [key] param.
  Future<bool> update(SerializableModel object) =>
      updateJson(object.key, object.id, object.toJson());

  /// Update the record with id [id]
  /// The table is inferred through the [key] param
  Future<bool> updateJson(String key, String id, Map<String, dynamic> json) => _collection(key)
          .doc(id)
          .set(json
            ..remove('id')
            ..remove('key'))
          .then((_) => true)
          .onError((error, stackTrace) {
        logger.severe('Error on update record $id in \'$key\'', error, stackTrace);
        return false;
      });

  /// Update the record with id [id] using the [update] function.
  /// The table is inferred through the [key] param.
  Future<bool> functionalUpdate(
      String key, String id, Map<String, dynamic> Function(Map<String, dynamic>) update) async {
    var record = await getFromId(key, id);
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

  /// Remove a [SerializableModel1] instance.
  /// The table is inferred through the [key] param.
  Future<bool> remove(SerializableModel object) => removeFromId(object.key, object.id);

  /// Remove all [SerializableModel1] instances that satisfy the predicate.
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
  Future<Map<String, dynamic>?> getFromId(String key, String id) =>
      _collection(key).doc(id).get().then((result) {
        final data = result.data() as Map<String, dynamic>?;
        data?['id'] = id;
        data?['key'] = key;

        return data;
      }).onError((error, stackTrace) {
        logger.severe('Unable to fetch record $id from \'$key\'', error, stackTrace);
        return null;
      });

  /// Return all records that satisfies the [query].
  /// The table is inferred through the [key] param.
  Future<List<Map<String, dynamic>>> getFromQuery(PersistenceQuery query) =>
      query.toFirestoreQuery
          .get()
          .then((result) => result.docs.map((element) {
                final data = element.data() as Map<String, dynamic>;
                data['id'] = element.id;
                data['key'] = query.key;

                return data;
              }).toList())
          .onError((error, stackTrace) {
        logger.severe('Unable to fetch records from \'${query.key}\'', error, stackTrace);
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

  PersistenceQuery isGreaterThanOrEqualTo({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, isGreaterThanOrEqualTo: value));

  PersistenceQuery arrayContains({required String field, required Object value}) =>
      PersistenceQuery._(key, _query.where(field, arrayContains: value));

  PersistenceQuery arrayContainsAny({required String field, required List<Object> value}) =>
      PersistenceQuery._(key, _query.where(field, arrayContainsAny: value));

  PersistenceQuery whereIn({required String field, required List<Object> value}) =>
      PersistenceQuery._(key, _query.where(field, whereIn: value));

  PersistenceQuery whereNotIn({required String field, required List<Object> value}) =>
      PersistenceQuery._(key, _query.where(field, whereNotIn: value));

  PersistenceQuery isNull({required String field, required bool isNull}) =>
      PersistenceQuery._(key, _query.where(field, isNull: isNull));
}
