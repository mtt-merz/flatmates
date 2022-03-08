import 'package:flatmates/app/models/user/user.dart';
import 'package:flatmates/app/repositories/repository.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart' show Logger;

export 'package:flatmates/app/models/user/user.dart';

class UserRepository with Repository<User> {
  Logger get logger => Logger(runtimeType.toString());
  final _persistence = GetIt.I<PersistenceService>();

  final String _key = 'users';

  void load(String userId) async {
    final rawUser = await _persistence.getFromId(_key, userId);
    if (rawUser != null) return addEvent(User.fromJson(rawUser));

    // No stored user instance: create and store a new one
    final user = User(userId);
    await _persistence.update(_key, user);

    return addEvent(user);
  }

  Future<void> update(User Function(User) updater) async {
    final user = updater(await data);

    addEvent(user);
    await _persistence.update(_key, user);
  }

  Future<void> remove() async => _persistence.remove(_key, await data);
}
