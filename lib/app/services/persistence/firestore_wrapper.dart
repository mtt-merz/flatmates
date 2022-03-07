import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:logging/logging.dart' show Logger;

/// Get the [StoreRef] instance relative to the [key] param
CollectionReference _collection(String key) => FirebaseFirestore.instance.collection(key);

class FirestoreWrapper implements PersistenceService {
  Logger get logger => Logger(runtimeType.toString());

  @override
  void dispose() {}

  @override
  String generateId(String key) => _collection(key).doc().id;

  @override
  Future<bool> insert(String key, SerializableModel object) =>
      insertJson(key, object.id, object.toJson());

  @override
  Future<bool> insertJson(String key, String id, Map<String, dynamic> json) => _collection(key)
          .doc(id)
          .set(json
            ..remove('id')
            ..remove('key'))
          .then((value) {
        logger.info('Inserted record $id in \'$key\' updated');
        return true;
      }).onError((error, stackTrace) {
        logger.severe('Error on insert record $id in \'$key\'', error, stackTrace);
        return false;
      });

  @override
  Future<bool> update(String key, SerializableModel object) =>
      updateJson(key, object.id, object.toJson());

  @override
  Future<bool> updateJson(String key, String id, Map<String, dynamic> json) => _collection(key)
          .doc(id)
          .set(json
            ..remove('id')
            ..remove('key'))
          .then((_) {
        logger.info('Record $id of \'$key\' updated');
        return true;
      }).onError((error, stackTrace) {
        logger.severe('Error on update record $id in \'$key\'', error, stackTrace);
        return false;
      });

  @override
  Future<bool> functionalUpdate(
      String key, String id, Map<String, dynamic> Function(Map<String, dynamic>) update) async {
    var record = await getFromId(key, id);
    assert(record != null);

    return await updateJson(key, id, update(record!));
  }

  @override
  Future<bool> removeFromId(String key, String id) => _collection(key).doc(id).delete().then((_) {
        logger.info('Removed record $id from \'$key\'');
        return true;
      }).onError((error, stackTrace) {
        logger.severe('Unable to remove record $id in \'$key\'', error, stackTrace);
        return false;
      });

  @override
  Future<bool> remove(String key, SerializableModel object) => removeFromId(key, object.id);

  // @override
  // Future<void> removeWhere(
  //         String key, bool Function(Map<String, dynamic>) predicate) async =>
  //     await _store(key).delete(_db,
  //         finder: Finder(
  //           filter: Filter.custom((record) => predicate(record.value)),
  //         ));

  @override
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

  @override
  Future<List<Map<String, dynamic>>> getFromQuery(PersistenceQuery query) => query.toFirestoreQuery
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
