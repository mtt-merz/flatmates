import 'package:flatmates/app/models/flat/flat.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart' show Logger;

import 'repository.dart';

export 'package:flatmates/app/models/flat/flat.dart';

class FlatRepository with Repository<Flat> {
  Logger get logger => Logger(runtimeType.toString());
  static final _persistence = GetIt.I<PersistenceService>();

  final String _key = 'flats';

  Future<void> load(String flatId) async {
    final rawFlat = await _persistence.getFromId(_key, flatId);
    if (rawFlat == null) throw LoadRepositoryFailure();

    addEvent(Flat.fromJson(rawFlat));
  }

  Future<void> insert(Flat flat) async {
    addEvent(flat);
    await _persistence.insert(_key, flat);
  }

  Future<void> update(Flat Function(Flat) updater) async =>
      _persistence.update(_key, updater(await data));

  Future<void> remove() async => _persistence.remove(_key, await data);

  // TODO: put this method into a cubit
  Future<void> removeMate(String userId) async {
    data.then((flat) {
      flat.mates.removeWhere((mate) => mate.userId == userId);
      if (flat.mates.isEmpty)
        remove();
      else
        update((flat) => flat);
    });
  }
}
