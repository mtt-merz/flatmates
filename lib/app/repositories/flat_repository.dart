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

  Future<void> init(String flatId) async {
    final rawFlat = await _persistence.getFromId(_key, flatId);
    if (rawFlat == null) throw LoadRepositoryFailure();

    addEvent(Flat.fromJson(rawFlat));
  }

  Future<void> insert(Flat flat) {
    addEvent(flat);
    return _persistence.insert(_key, flat);
  }

  Future<void> update(Flat Function(Flat) updater) {
    final flat = updater(value);

    addEvent(flat);
    return _persistence.update(_key, flat);
  }

  Future<void> remove() {
    // addEvent(null);
    return _persistence.remove(_key, value);
  }
}
