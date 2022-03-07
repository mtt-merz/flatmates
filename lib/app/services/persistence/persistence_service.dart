import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flatmates/app/services/service.dart';

import 'firestore_wrapper.dart';

abstract class PersistenceService implements Service {
  /// Generate an unique ID for a generic collection.
  String generateId(String key);

  /// Store [object] into the DB.
  /// The table is inferred through the [key] param.
  Future<bool> insert(String key, SerializableModel object);

  /// Store the json [json] into the DB.
  /// The table is inferred through the [key] param.
  Future<bool> insertJson(String key, String id, Map<String, dynamic> json);

  /// Update a [SerializableModel1] instance.
  /// The table is inferred through the [key] param.
  Future<bool> update(String key, SerializableModel object) =>
      updateJson(key, object.id, object.toJson());

  /// Update the record with id [id]
  /// The table is inferred through the [key] param
  Future<bool> updateJson(String key, String id, Map<String, dynamic> json);

  /// Update the record with id [id] using the [update] function.
  /// The table is inferred through the [key] param.
  Future<bool> functionalUpdate(
      String key, String id, Map<String, dynamic> Function(Map<String, dynamic>) update);

  /// Remove the record with id [id].
  /// The table is inferred through the [key] param.
  Future<bool> removeFromId(String key, String id);

  /// Remove a [SerializableModel1] instance.
  /// The table is inferred through the [key] param.
  Future<bool> remove(String key, SerializableModel object);

  /// Remove all [SerializableModel1] instances that satisfy the predicate.
  /// The table is inferred through the [key] param.
  // Future<void> removeWhere(String key, bool Function(Map<String, dynamic>) predicate);

  /// Return the record with id [id].
  /// The table is inferred through the [key] param.
  Future<Map<String, dynamic>?> getFromId(String key, String id);

  /// Return all records that satisfies the [query].
  /// The table is inferred through the [key] param.
  Future<List<Map<String, dynamic>>> getFromQuery(PersistenceQuery query);
}
