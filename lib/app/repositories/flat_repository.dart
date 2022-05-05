import 'package:flatmates/app/models/flat/flat.dart';
import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:flatmates/locator.dart';

import 'repository.dart';

export 'package:flatmates/app/models/flat/flat.dart';

class FlatRepository with Repository<Flat?> {
  static FlatRepository get i => Locator.get<FlatRepository>();
  static final _persistence = Locator.get<PersistenceService>();

  FlatRepository() {
    UserRepository.i.breakingStream.listen((user) async {
      if (user == null && _currentMateId != null) return removeCurrentMate();

      _currentMateId = user?.id;
      if (user == null) return;

      final flatId = user.currentFlatId;
      flatId != null ? fetch(flatId) : addBreakingEvent(null);
    });
  }

  String? _currentMateId;

  Future<void> fetch(String flatId) async {
    final rawFlat = await _persistence.getFromId(Flat.key, flatId);
    if (rawFlat == null) throw FetchRepositoryFailure<FlatRepository>(flatId);

    addBreakingEvent(Flat.fromJson(rawFlat));
  }

  Future<void> fetchFromInvitationCode(String invitationCode) async {
    final result = await _persistence.getAll(Flat.key);

    for (Map<String, dynamic> rawFlat in result)
      if (rawFlat["invitationCode"] == invitationCode) {
        await fetch(rawFlat['id']);
        return;
      }

    throw FetchRepositoryFailure<FlatRepository>(invitationCode);
  }

  Future<void> insert(Flat flat) {
    addBreakingEvent(flat);
    return _persistence.insert(Flat.key, flat);
  }

  Future<void> updateFunctional(Flat Function(Flat) updater) =>
      update(updater(value!));

  Future<void> update(Flat flat) async {
    addEvent(flat);
    await _persistence.update(Flat.key, flat);
  }

  Future<void> remove() async {
    await _persistence.remove(Flat.key, value!);
    addBreakingEvent(null);
  }

  Future<void> updateMate(Mate newMate) => updateFunctional((flat) => flat
    ..mates.remove(loggedMate(newMate.userId))
    ..mates.add(newMate));

  Future<void> updateMateUserId(String oldUserId, String newUserId) {
    final oldMate = loggedMate(oldUserId);
    if (oldMate == null) throw 'No logged mate found';

    return updateFunctional((flat) => flat
      ..mates.remove(oldMate)
      ..mates.add(oldMate.copyWith(userId: newUserId)));
  }

  Future<void> removeMate(String userId) async {
    await updateFunctional((flat) => flat..mates.remove(loggedMate(userId)));
    if (value!.mates.isEmpty) await remove();
  }

  Future<void> removeCurrentMate() => removeMate(_currentMateId!);

  Mate? loggedMate(String userId) {
    try {
      return value!.mates.singleWhere((mate) => mate.userId == userId);
    } on StateError catch (_) {
      return null;
    }
  }
}
