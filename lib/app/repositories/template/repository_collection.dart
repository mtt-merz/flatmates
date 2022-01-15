import 'dart:async';

import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flatmates/app/repositories/template/repository_mixin.dart';
import 'package:flatmates/app/services/persistence.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:rxdart/rxdart.dart';

abstract class RepositoryCollection<T extends SerializableModel> with RepositoryMixin<List<T>> {
  Logger get _logger => Logger(runtimeType.toString());

  final PersistenceQuery query;

  final T Function(Map<String, dynamic>) builder;

  @override
  Stream<List<T>> get stream => _streamController.stream;

  final BehaviorSubject<List<T>> _streamController = BehaviorSubject();
  late final List<T> objects;

  RepositoryCollection({required this.query, required this.builder}) {
    Persistence.instance.getFromQuery(query).then((result) {
      objects = result.map(builder).toList();
      _logger.info('Found ${objects.length} ${query.key}');

      _streamController.add(objects);
    });
  }

  void stop() => _streamController.close();

  void refresh();

  Future<void> insert(T object) async {
    final result = await Persistence.instance.insert(object);
    if (!result) return _logger.warning('Unable to insert $object');

    objects.add(object);
    refresh();
    _logger.info('Inserted $object');
  }

  Future<void> update(T object) async {
    final result = await Persistence.instance.update(object);
    if (!result) return _logger.warning('Unable to update $object');

    objects.remove(object);
    objects.add(object);
    refresh();
    _logger.info('Updated $object');
  }

  Future<void> delete(T object) async {
    final result = await Persistence.instance.remove(object);
    if (!result) return _logger.warning('Unable to delete $object');

    objects.remove(object);
    refresh();
    _logger.info('Deleted $object');
  }
}
