import 'package:flatmates/app/models/user/user.dart';
import 'package:flatmates/app/repositories/repository.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:flatmates/locator.dart';

export 'package:flatmates/app/models/user/user.dart';

class UserRepository with Repository<User?> {
  static UserRepository get i => Locator.get<UserRepository>();

  final _persistence = Locator.get<PersistenceService>();

  Future<void> fetch(String userId) async {
    final rawUser = await _persistence.getFromId(User.key, userId);
    if (rawUser == null) throw FetchRepositoryFailure<UserRepository>(userId);

    addEvent(User.fromJson(rawUser));
  }

  Future<void> insert(User user) async {
    await _persistence.insert(User.key, user);
    addEvent(user);
  }

  Future<void> update(User user) async {
    await _persistence.update(User.key, user);
    addEvent(user);
  }

  /// If [value] is null, throw an exception
  Future<void> updateFunctional(User Function(User) updater) => update(updater(value!));

  /// If [value] is null, throw an exception
  Future<void> remove() async {
    await _persistence.remove(User.key, value!);
    addEvent(null);
  }
}
