import 'dart:async';

import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flatmates/app/repositories/repository.dart';
import 'package:flatmates/app/services/persistence/firestore_wrapper.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart' show Logger;

abstract class RepositoryCollection<T extends SerializableModel> with Repository<List<T>> {
  Logger get _logger => Logger(runtimeType.toString());
  static final _persistence = GetIt.I<PersistenceService>();

  final PersistenceQuery query;
  final String key;

  final T Function(Map<String, dynamic>) builder;

  late final List<T> objects;

  RepositoryCollection({required this.key, required this.query, required this.builder}) {
    _persistence.getFromQuery(query).then((result) {
      objects = result.map(builder).toList();
      _logger.info('Found ${objects.length} ${query.key}');

      addEvent(objects);
    });
  }

  void refresh();

  Future<void> insert(T object) async {
    final result = await _persistence.insert(key, object);
    if (!result) return _logger.warning('Unable to insert $object');

    addEvent(objects..add(object));
  }

  Future<void> update(T object) async {
    final result = await _persistence.update(key, object);
    if (!result) return _logger.warning('Unable to update $object');

    addEvent(objects
      ..remove(object)
      ..add(object));
  }

  Future<void> delete(T object) async {
    final result = await _persistence.remove(key, object);
    if (!result) return _logger.warning('Unable to delete $object');

    addEvent(objects..remove(object));
  }
}
