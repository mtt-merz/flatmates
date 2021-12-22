import 'dart:async';

import 'package:flatmates/app/models/template/serializable_model.dart';
import 'package:flatmates/app/services/persistence/persistence.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:rxdart/rxdart.dart';

abstract class CollectionRepository<T extends ExtendedSerializableModel> {
  Logger get _logger => Logger(runtimeType.toString());

  String get _key => query.key;
  final PersistenceQuery query;

  final T Function(Map<String, dynamic>) builder;

  Stream<List<T>> get stream => _streamController.stream;
  final BehaviorSubject<List<T>> _streamController = BehaviorSubject();
  late final List<T> objects;

  CollectionRepository({required this.query, required this.builder}) {
    Persistence.instance.getQuery(_key, query).then((result) {
      objects = result.map(builder).toList();
      _logger.info('Found ${objects.length} $_key');

      _streamController.add(objects);
    });
  }

  void stop() => _streamController.close();

  void refresh();

  Future<void> insert(T object) async {
    final result = await Persistence.instance.insert(_key, object);
    if (!result) return _logger.warning('Unable to insert $object');

    objects.add(object);
    refresh();
    _logger.info('Inserted $object');
  }

  Future<void> update(T object) async {
    final result = await Persistence.instance.update(_key, object);
    if (!result) return _logger.warning('Unable to update $object');

    objects.remove(object);
    objects.add(object);
    refresh();
    _logger.info('Updated $object');
  }

  Future<void> delete(T object) async {
    final result = await Persistence.instance.remove(_key, object);
    if (!result) return _logger.warning('Unable to delete $object');

    objects.remove(object);
    refresh();
    _logger.info('Deleted $object');
  }
}
