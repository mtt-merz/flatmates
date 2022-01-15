import 'dart:async';

import 'package:flatmates/app/models/serializable_model.dart';
import 'package:flatmates/app/services/persistence.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:rxdart/rxdart.dart';

abstract class RepositoryObject<T extends SerializableModel> {
  Logger get logger => Logger(runtimeType.toString());

  final String key;
  final String id;

  final T Function(Map<String, dynamic>) builder;

  RepositoryObject({required this.key, required this.id, required this.builder}) {
    initialize();
  }

  void initialize() => Persistence.instance.getFromId(key, id).then((result) {
        if (result == null) return _streamController.add(null);
        return _streamController.add(builder(result));
      });

  void stop() => _streamController.close();

  final BehaviorSubject<T?> _streamController = BehaviorSubject();

  Stream<T?> get stream => _streamController.stream;

  Future<T?> get data => _streamController.first;

  Future<void> update(T? object) {
    if (object == null) return delete();

    _streamController.add(object);
    return Persistence.instance.update(object).then((result) {
      if (!result) return logger.warning('Unable to update $object');
      logger.info('Updated $object');
    });
  }

  Future<void> delete() {
    _streamController.add(null);
    return Persistence.instance
        .removeFromId(key, id)
        .then((result) => logger.info('Deleted $data'));
  }
}
