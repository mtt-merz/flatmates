import 'package:flatmates/app/models/flat/flat.dart';
import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:flatmates/locator.dart';

import 'repository.dart';

export 'package:flatmates/app/models/flat/flat.dart';

class FlatRepository with Repository<Flat> {
  static FlatRepository get i => Locator.get<FlatRepository>();

  static final _persistence = Locator.get<PersistenceService>();

  Future<void> fetch(String flatId) async {
    final rawFlat = await _persistence.getFromId(Flat.key, flatId);
    if (rawFlat == null) throw FetchRepositoryFailure<FlatRepository>(flatId);

    addEvent(Flat.fromJson(rawFlat));
  }

  Future<void> insert(Flat flat) {
    addEvent(flat);
    return _persistence.insert(Flat.key, flat);
  }

  Future<void> update(Flat Function(Flat) updater) {
    final flat = updater(value);

    addEvent(flat);
    return _persistence.update(Flat.key, flat);
  }

  Future<void> remove() {
    // addEvent(null);
    return _persistence.remove(Flat.key, value);
  }

  Future<void> updateMate(Mate newMate) => update((flat) => flat
    ..mates.remove(loggedMate(newMate.userId))
    ..mates.add(newMate));

  Future<void> updateMateUserId(String oldUserId, String newUserId) {
    final oldMate = loggedMate(oldUserId);

    return update((flat) => flat
      ..mates.remove(oldMate)
      ..mates.add(oldMate!.copyWith(userId: newUserId)));
  }

  Future<void> removeMate(String userId) =>
      update((flat) => flat..mates.remove(loggedMate(userId)));

  Mate? loggedMate(String userId) =>
      valueOrNull?.mates.singleWhere((mate) => mate.userId == userId);
}
