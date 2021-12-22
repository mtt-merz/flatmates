import 'dart:async';

import 'package:flatmates/app/services/persistence/persistence.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:rxdart/rxdart.dart';

import '../../models/template/serializable_model.dart';

abstract class ObjectRepository<T extends ExtendedSerializableModel> {
  Logger get _logger => Logger(runtimeType.toString());

  final String _key;
  final String _id;

  final T Function(Map<String, dynamic>) builder;

  Stream<T> get stream => _streamController.stream;
  final BehaviorSubject<T> _streamController = BehaviorSubject();
  late final T object;

  ObjectRepository(this._key, this._id, {required this.builder}) {
    Persistence.instance.get(_key, _id).then((result) {
      if (result == null) throw 'Object not found in $_key';

      object = builder(result);
      _streamController.add(object);
    });
  }

  void stop() => _streamController.close();

  void refresh();

  Future<void> update(T object) async {
    final res = await Persistence.instance.update(_key, object);
    if (!res) return _logger.warning('Unable to update $object');
    _logger.info('Updated $object');
  }
}
