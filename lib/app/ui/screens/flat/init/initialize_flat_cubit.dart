import 'dart:math';

import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

enum FlatState { regular, notFound, joining, generating }

class InitializeFlatCubit extends Cubit<AsyncSnapshot<FlatState>> {
  final _userRepository = GetIt.I<UserRepository>();
  final _flatRepository = GetIt.I<FlatRepository>();

  InitializeFlatCubit() : super(const AsyncSnapshot.waiting()) {
    _userRepository.stream.listen((user) {
      if (user.flatId == null)
        emit(const AsyncSnapshot.withData(ConnectionState.active, FlatState.notFound));
      else {
        _flatRepository.init(user.flatId!);
        emit(const AsyncSnapshot.withData(ConnectionState.active, FlatState.regular));
      }
    });
  }

  void joinFlat(String invitationCode) {}

  void createFlat() =>
      emit(const AsyncSnapshot.withData(ConnectionState.active, FlatState.generating));

  void setUsername(String username) async {
    final user = _userRepository.value;
    final mate = Mate(user.id, name: username, colorValue: _randomPrimaryColor.value);

    switch (state.data) {
      case FlatState.generating:
        final flat = Flat(mate: mate);
        await _flatRepository.insert(flat);
        await _userRepository.update(user..flatId = flat.id);
        break;
      case FlatState.joining:
        await _flatRepository.update((flat) => flat..mates.add(mate));
        break;
      default:
    }

    emit(const AsyncSnapshot.withData(ConnectionState.done, FlatState.regular));
  }

  Color get _randomPrimaryColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
