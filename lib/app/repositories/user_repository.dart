import 'dart:async';

import 'package:flatmates/app/models/user.dart';
import 'package:flatmates/app/services/authentication_service.dart';
import 'package:flatmates/app/services/persistence/persistence.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

export 'package:flatmates/app/models/user.dart';

const _key = 'users';

class UserRepository {
  Logger get _logger => Logger(runtimeType.toString());

  static UserRepository get instance => _instance ??= UserRepository._();
  static UserRepository? _instance;

  late User user;

  UserRepository._() {
    userStream.listen((user) => this.user = user);

    // Get the stored user, if any
    Persistence.instance.get(_key, AuthenticationService.instance.userId).then(
          (result) => result != null
              ? _userStreamController.add(User.fromJson(result))
              : set(User(AuthenticationService.instance.userId)),
        );
  }

  Stream<User> get userStream => _userStreamController.stream;
  final BehaviorSubject<User> _userStreamController = BehaviorSubject();

  void update(User Function(User) updater) => set(updater(user));

  void set(User user) => Persistence.instance
      .update(_key, user)
      .then((_) => _userStreamController.add(user));
}
