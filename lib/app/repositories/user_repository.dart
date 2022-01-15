import 'package:flatmates/app/models/user/user.dart';
import 'package:flatmates/app/repositories/template/repository_mixin.dart';
import 'package:flatmates/app/services/persistence.dart';
import 'package:rxdart/rxdart.dart';

export 'package:flatmates/app/models/user/user.dart';

class UserRepository with RepositoryMixin<User> {
  static late UserRepository instance;

  static Future<void> init(String userId) async {
    final rawUser = await Persistence.instance.getFromId(userKey, userId);
    if (rawUser != null)
      instance = UserRepository._(User.fromJson(rawUser));
    else {
      // No stored user instance: create and store a new one
      final user = User(userId);
      await Persistence.instance.update(user);

      instance = UserRepository._(user);
    }
  }

  final BehaviorSubject<User> _streamController = BehaviorSubject();

  UserRepository._(User user) {
    _streamController.add(user);
  }

  void update(User user) {
    _streamController.add(user);
    Persistence.instance.update(user);
  }

  @override
  Stream<User> get stream => _streamController.stream;
}
