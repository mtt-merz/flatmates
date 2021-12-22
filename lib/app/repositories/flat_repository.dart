import 'dart:async';

import 'package:flatmates/app/models/flat.dart';
import 'package:flatmates/app/repositories/template/object_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';

export 'package:flatmates/app/models/flat.dart';

/// This repository provides the logged [User] flat
/// It should be refreshed anytime the user changes.
class FlatRepository extends ObjectRepository<Flat> {
  static FlatRepository get instance =>
      _instance ??= FlatRepository._(UserRepository.instance.user.flat);
  static FlatRepository? _instance;

  FlatRepository._(String flatId) : super(Flat.key, flatId, builder: Flat.fromJson);

  @override
  void refresh() => _instance = null;

  @override
  Future<void> update(Flat object) {
    UserRepository.instance.dynamicUpdate((user) => user..flat = object.id);
    return super.update(object);
  }
}
