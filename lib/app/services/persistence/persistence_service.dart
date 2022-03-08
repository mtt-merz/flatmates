import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flatmates/app/services/service.dart';

abstract class PersistenceService implements Service {
  /// Store [object] into the DB.
  /// The table is inferred through the [key] param.
  Future<void> insert(String key, SerializableModel object);

  /// Store the json [json] into the DB.
  /// The table is inferred through the [key] param.
  Future<void> insertJson(String key, String id, Map<String, dynamic> json);

  /// Update a [SerializableModel] instance.
  /// The table is inferred through the [key] param.
  Future<void> update(String key, SerializableModel object);

  /// Update the record with id [id]
  /// The table is inferred through the [key] param
  Future<void> updateJson(String key, String id, Map<String, dynamic> json);

  /// Remove the record with id [id].
  /// The table is inferred through the [key] param.
  Future<void> removeFromId(String key, String id);

  /// Remove a [SerializableModel] instance.
  /// The table is inferred through the [key] param.
  Future<void> remove(String key, SerializableModel object);

  /// Remove all [SerializableModel] instances that satisfy the predicate.
  /// The table is inferred through the [key] param.
  Future<void> removeAll(String key);

  /// Return the record with id [id].
  /// The table is inferred through the [key] param.
  Future<Map<String, dynamic>?> getFromId(String key, String id);

  /// Return all records of the table inferred through the [key] param.
  Future<List<Map<String, dynamic>>> getAll(String key);
}

class PersistenceServiceError {
  final String action;
  final String key;
  final String? id;

  PersistenceServiceError(this.action, this.key, this.id);

  @override
  String toString() => 'Error on ${action.toUpperCase()} record(s) $id in \'$key\'';
}
