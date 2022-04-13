import 'dart:math';

import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class InitCubitState {}

class Loading extends InitCubitState {}

class ShouldInitializeFlat extends InitCubitState {
  final bool hasError;

  ShouldInitializeFlat({this.hasError = false});
}

class ShouldSetName extends InitCubitState {
  final bool hasError;
  final bool isLoading;

  ShouldSetName({this.hasError = false, this.isLoading = false});
}

class Initialized extends InitCubitState {}

class InitCubit extends Cubit<InitCubitState> {
  final _userRepository = Locator.get<UserRepository>();
  final _flatRepository = Locator.get<FlatRepository>();

  InitCubit() : super(Loading()) {
    _userRepository.stream.listen((user) async {
      if (user == null) return;

      if (user.flatIds.isEmpty) return emit(ShouldInitializeFlat());

      if (user.currentFlatId == null)
        await _userRepository.update(user..currentFlatId = user.flatIds.first);

      await _flatRepository.fetch(user.currentFlatId!);
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

    emit(ShouldSetName(isLoading: true));
    final user = _userRepository.value;
    final mate = Mate(name,
        userId: user!.id,
        colorValue: Colors.primaries[Random().nextInt(Colors.primaries.length)].value);

    if (_flatRepository.hasValue) {
      // Check for other mates with the same name
      if (_flatRepository.value.mates.any((element) => element.name == name))
        emit(ShouldSetName(hasError: true));

      await _flatRepository.update((flat) => flat..mates.add(mate));
    } else
      await _flatRepository.insert(Flat(mate: mate));

    final flat = _flatRepository.value;
    await _userRepository.update(user
      ..flatIds.add(flat.id)
      ..currentFlatId = flat.id);

    emit(Initialized());
  }
}
