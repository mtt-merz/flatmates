import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart' show Logger;

import 'package:flatmates/app/repositories/template/models/persistence_event.dart';
import 'package:flatmates/app/repositories/template/models/serializable_model.dart';

class Persistence {
  Logger get logger => Logger(runtimeType.toString());

  static Persistence get instance => _instance ??= Persistence._();
  static Persistence? _instance;

  /// Free all resources
  static void dispose() {
    if (_instance == null) return;
  }

  final FirebaseFirestore _firestore;

  Persistence._() : _firestore = FirebaseFirestore.instance;

  void addStoreListener(String key, void Function(PersistenceEvent) onChange) =>
      _collection(key).snapshots().listen((event) {
        for (var change in event.docChanges)
          switch (change.type) {
            case DocumentChangeType.added:
              // A new record has been ADDED
              onChange(PersistenceEvent.insert(
                collection: key,
                recordId: change.doc.id,
                record: change.doc.data() as Map<String, dynamic>,
              ));
              break;
            case DocumentChangeType.modified:
              // A record has been UPDATED
              onChange(PersistenceEvent.update(
                collection: key,
                recordId: change.doc.id,
                record: change.doc.data() as Map<String, dynamic>,
              ));
              break;
            case DocumentChangeType.removed:
              // A record has been DELETED
              onChange(PersistenceEvent.delete(
                collection: key,
                recordId: change.doc.id,
                record: change.doc.data() as Map<String, dynamic>,
              ));
              break;
          }
      });

  /// Store the json [json] into the DB.
  /// The table is inferred through the [key] param.
  Future<bool> insertJson(String key, String id, Map<String, dynamic> json) {
    json.remove('id');
    return _collection(key)
        .add(json)
        .then((value) => true)
        .onError((error, stackTrace) {
      logger.severe(
          'Error on insert record $id in \'$key\'', error, stackTrace);
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
      logger.severe(
          'Error on update record $id in \'$key\'', error, stackTrace);
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
  Future<bool> removeFromId(String key, String id) => _collection(key)
          .doc(id)
          .delete()
          .then((_) => true)
          .onError((error, stackTrace) {
        logger.severe(
            'Unable to remove record $id in \'$key\'', error, stackTrace);
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
        logger.severe(
            'Unable to fetch record $id from \'$key\'', error, stackTrace);
        return null;
      });

  /// Return all records that satisfies the [query].
  /// The table is inferred through the [key] param.
  Future<List<Map<String, dynamic>>> _getQuery(String key, Query query) => query
          .get()
          .then((result) => result.docs.map((element) {
                final data = element.data() as Map<String, dynamic>;
                data['id'] = element.id;
                return data;
              }).toList())
          .onError((error, stackTrace) {
        logger.severe(
            'Unable to fetch records from \'$key\'', error, stackTrace);
        return [];
      });

  /// Return all records stored in the [key] table.
  /// The relative objects should be built through the proper Service class.
  Future<List<Map<String, dynamic>>> getAll(String key) =>
      _getQuery(key, _collection(key));

  Future<List<Map<String, dynamic>>> getWhereFieldContains(String key,
          {required String field, required String value}) =>
      _getQuery(key, _collection(key).where(field, arrayContains: value));

  /// Get the [StoreRef] instance relative to the [key] param
  CollectionReference _collection(String key) => _firestore.collection(key);
}
