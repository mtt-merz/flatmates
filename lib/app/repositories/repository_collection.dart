import 'dart:async';

import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flatmates/app/repositories/repository.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart' show Logger;

abstract class RepositoryCollection<T extends SerializableModel> with Repository<List<T>> {
  Logger get _logger => Logger(runtimeType.toString());
  static final _persistence = GetIt.I<PersistenceService>();

  /// Build a [T] instance starting from a json value
  final T Function(Map<String, dynamic>) builder;

  RepositoryCollection({required this.builder});

  late String key;

  Future<void> load(String key) async {
    final rawData = await _persistence.getAll(key);
    objects = rawData.map(builder).toList();
    _logger.info('Found ${objects.length} $key');

    addEvent(objects);
  }

  late final List<T> objects;

  Future<void> insert(T object) async {
    addEvent(objects..add(object));
    return _persistence.insert(key, object);
  }

  Future<void> update(T object) async {
    addEvent(objects
      ..remove(object)
      ..add(object));
    return _persistence.update(key, object);
  }

  Future<void> remove(T object) async {
    addEvent(objects..remove(object));
    _persistence.remove(key, object);
  }
}
