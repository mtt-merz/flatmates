import 'dart:async';

import 'package:flatmates/app/models/user.dart';
import 'package:flatmates/app/services/authentication_service.dart';

import 'template/object_repository.dart';

export 'package:flatmates/app/models/user.dart';

class UserRepository extends ObjectRepository<User> {
  static UserRepository get instance =>
      _instance ??= UserRepository._(AuthenticationService.instance.userId);
  static UserRepository? _instance;

  User get user => object;

  UserRepository._(String userId) : super(User.key, userId, builder: User.fromJson);

  @override
  void refresh() => _instance = null;

  // TODO: implement this method in the ViewModel
  Future<void> dynamicUpdate(User Function(User) updater) async =>
      update(updater(await stream.first));
}
