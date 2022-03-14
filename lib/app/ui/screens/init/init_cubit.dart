import 'dart:math';

import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class InitCubitState {}

class Loading extends InitCubitState {}

class ShouldInitializeFlat extends InitCubitState {
  final bool hasError;

  ShouldInitializeFlat({this.hasError = false});
}

class ShouldSetName extends InitCubitState {
  final bool hasError;

  ShouldSetName({this.hasError = false});
}

class Initialized extends InitCubitState {}

class InitCubit extends Cubit<InitCubitState> {
  final _userRepository = GetIt.I<UserRepository>();
  final _flatRepository = GetIt.I<FlatRepository>();

  InitCubit() : super(Loading()) {
    _userRepository.stream.listen((user) async {
      if (user.flatId == null) return emit(ShouldInitializeFlat());

      await _flatRepository.init(user.flatId!);
      emit(Initialized());
    });
  }

  void joinFlat(String invitationCode) {
    // TODO: fetch flatId and load the flat by calling _flatRepository.init(flatId)
  }

  void createFlat() => emit(ShouldSetName());

  bool checkName(String name) => name.isNotEmpty;

  void setName(String name) async {
    if (name.isEmpty) return emit(ShouldSetName(hasError: true));

    final user = _userRepository.value;
    final mate = Mate(name,
        userId: user.id,
        colorValue: Colors.primaries[Random().nextInt(Colors.primaries.length)].value);

    if (_flatRepository.hasValue) {
      // Check for other mates with the same name
      if (_flatRepository.value.mates.any((element) => element.name == name))
        emit(ShouldSetName(hasError: true));

      await _flatRepository.update((flat) => flat..mates.add(mate));
    } else
      await _flatRepository.insert(Flat(mate: mate));

    final flat = _flatRepository.value;
    await _userRepository.update(user..flatId = flat.id);

    emit(Initialized());
  }
}
