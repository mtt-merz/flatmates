import 'package:flatmates/app/models/flat/flat.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart' show Logger;

import 'repository.dart';

export 'package:flatmates/app/models/flat/flat.dart';

class FlatRepository with Repository<Flat> {
  Logger get logger => Logger(runtimeType.toString());
  static final _persistence = GetIt.I<PersistenceService>();

  Future<void> load(String flatId) async {
    final rawFlat = await _persistence.getFromId(Flat.key, flatId);
    if (rawFlat != null) addEvent(Flat.fromJson(rawFlat));
  }

  Future<void> insert(Flat flat) async {
    addEvent(flat);
    await _persistence.insert(Flat.key, flat);
  }

  Future<void> update(Flat flat) async {
    addEvent(flat);
    await _persistence.update(Flat.key, flat);
  }

  Future<void> remove() async => _persistence.remove(Flat.key, await data);

  Future<void> disconnectMate(String userId) async {
    data.then((flat) {
      flat.mates.singleWhere((mate) => mate.userId == userId).userId = null;

      // If there are no more connected mates, remove the flat
      if (!flat.mates.any((element) => element.userId != null)) remove();
    });
  }
}
