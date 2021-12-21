import 'dart:async';

import 'package:flatmates/app/services/persistence/persistence.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:rxdart/rxdart.dart';

import 'models/persistence_event.dart';
import 'models/serializable_model.dart';

abstract class Repository<T extends ExtendedSerializableModel> {
  Logger get _logger => Logger(runtimeType.toString());

  /// Identifies the store
  String get key;

  /// Build a [T] instance starting from a json value
  final T Function(Map<String, dynamic>) builder;

  List<T> get objects => List.unmodifiable(_objects);
  late final List<T> _objects;

  Stream<List<T>> get objectsStream => _objectsStreamController.stream;
  final BehaviorSubject<List<T>> _objectsStreamController = BehaviorSubject();

  void stop() => _objectsStreamController.close();

  Repository({
    required this.builder,
    required Future<List<Map<String, dynamic>>> Function() fetchObjects,
  }) {
    fetchObjects().then((result) {
      // Populate the object list
      _objects = result.map(builder).toList();
      _logger.info('Found ${_objects.length} $key');

      _objectsStreamController.add(_objects);

      // Start listening to the events of the current store
      Persistence.instance.addStoreListener(key, (event) {
        final object = builder(event.record);

        void add() => _objects.add(object);
        void remove() => _objects.removeWhere((obj) => obj.id == object.id);

        switch (event.type) {
          case PersistenceEventType.insert:
            remove();
            add();
            break;
          case PersistenceEventType.delete:
            remove();
            break;
          case PersistenceEventType.update:
            remove();
            add();
        }

        // Notify the stream listeners about the event
        _objectsStreamController.add(objects);
      });
    });
  }

  T? get(String id) => objects.singleWhere((element) => element.id == id);

  Future<void> insert(T object) async {
    final res = await Persistence.instance.insert(key, object);
    if (!res) return _logger.warning('Unable to insert $object');
    _logger.info('Inserted $object');
  }

  Future<void> update(T object) async {
    final res = await Persistence.instance.update(key, object);
    if (!res) return _logger.warning('Unable to update $object');
    _logger.info('Updated $object');
  }

  Future<void> delete(T object) async {
    final res = await Persistence.instance.remove(key, object);
    if (!res) return _logger.warning('Unable to delete $object');
    _logger.info('Deleted $object');
  }
}
