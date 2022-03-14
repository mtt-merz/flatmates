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

  Future<void> init(String userId) async {
    final rawUser = await _persistence.getFromId(_key, userId);
    if (rawUser == null) throw LoadRepositoryFailure();

    addEvent(User.fromJson(rawUser));
  }

  Future<void> insert(User user) {
    addEvent(user);
    return _persistence.insert(_key, user);
  }

  Future<void> update(User user) {
    addEvent(user);
    return _persistence.update(_key, user);
  }

  Future<void> remove() async => _persistence.remove(_key, value);
}
