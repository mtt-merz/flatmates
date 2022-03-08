import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, CollectionReference;
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
  Future<void> insert(String key, SerializableModel object) =>
      insertJson(key, object.id, object.toJson());

  @override
  Future<void> insertJson(String key, String id, Map<String, dynamic> json) {
       return _collection(key)
            .doc(id)
            .set(json..remove('id'))
            .then((value) => logger.info('Record $id added to \'$key\''))
            .catchError((error, stackTrace) {
          logger.severe('Error on insert record $id in \'$key\'', error, stackTrace);
          throw PersistenceServiceError('insert', key, id);
        });
  }

  @override
  Future<void> update(String key, SerializableModel object) =>
      updateJson(key, object.id, object.toJson());

  @override
  Future<void> updateJson(String key, String id, Map<String, dynamic> json) => _collection(key)
          .doc(id)
          .set(json..remove('id'))
          .then((_) => logger.info('Record $id in \'$key\' updated'))
          .catchError((error, stackTrace) {
        logger.severe('Error on update record $id in \'$key\'', error, stackTrace);
        throw PersistenceServiceError('update', key, id);
      });

  @override
  Future<void> remove(String key, SerializableModel object) => removeFromId(key, object.id);

  @override
  Future<void> removeFromId(String key, String id) => _collection(key)
          .doc(id)
          .delete()
          .then((_) => logger.info('Removed record $id from \'$key\''))
          .catchError((error, stackTrace) {
        logger.severe('Unable to remove record $id in \'$key\'', error, stackTrace);
        throw PersistenceServiceError('remove', key, id);
      });

  @override
  Future<void> removeAll(String key) => _collection(key).get().then((snapshot) {
        for (var element in snapshot.docs) element.reference.delete();
      }).onError((error, stackTrace) {
        logger.severe('Unable to fetch records from \'$key\'', error, stackTrace);
        throw PersistenceServiceError('getAll', key, null);
      });

  @override
  Future<Map<String, dynamic>?> getFromId(String key, String id) =>
      _collection(key).doc(id).get().then((result) {
        final data = result.data() as Map<String, dynamic>?;
        data?['id'] = id;

        return data;
      }).onError((error, stackTrace) {
        logger.severe('Unable to fetch record $id from \'$key\'', error, stackTrace);
        throw PersistenceServiceError('get', key, id);
      });

  @override
  Future<List<Map<String, dynamic>>> getAll(String key) => _collection(key)
          .get()
          .then((result) => result.docs.map((element) {
                final data = element.data() as Map<String, dynamic>;
                data['id'] = element.id;

                return data;
              }).toList())
          .onError((error, stackTrace) {
        logger.severe('Unable to fetch records from \'$key\'', error, stackTrace);
        throw PersistenceServiceError('getAll', key, null);
      });
}
