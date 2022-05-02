import 'dart:math';

import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class InitCubitState {}

class Loading extends InitCubitState {}

class ShouldJoinOrCreateFlat extends InitCubitState {
  final bool hasError;
  final bool isLoading;

  ShouldJoinOrCreateFlat({this.hasError = false, this.isLoading = false});
}

class ShouldSetName extends InitCubitState {
  final bool hasError;
  final bool isLoading;

  ShouldSetName({this.hasError = false, this.isLoading = false});
}

class Initialized extends InitCubitState {}

class InitCubit extends Cubit<InitCubitState> {
  InitCubit() : super(Loading()) {
    FlatRepository.i.breakingStream.listen((flat) async {
      if (flat == null) return emit(ShouldJoinOrCreateFlat());
      emit(Initialized());
    });
    // UserRepository.i.stream.listen((user) async {
    //   if (user == null) return;
    //
    //   if (user.flatIds.isEmpty) return emit(ShouldJoinOrCreateFlat());
    //
    //   if (user.currentFlatId == null)
    //     await UserRepository.i.update(user..currentFlatId = user.flatIds.first);
    //
    //   await FlatRepository.i.fetch(user.currentFlatId!);
    //   emit(Initialized());
    // });
  }

  void joinFlat(String invitationCode) {
    emit(ShouldJoinOrCreateFlat(isLoading: true));

    FlatRepository.i
        .fetchFromInvitationCode(invitationCode)
        .then((_) => emit(ShouldSetName()))
        .onError((_, __) => emit(ShouldJoinOrCreateFlat(hasError: true)));
  }

  void createFlat() => emit(ShouldSetName());

  bool checkName(String name) => name.isNotEmpty;

  void setName(String name) async {
    if (name.isEmpty) return emit(ShouldSetName(hasError: true));

    emit(ShouldSetName(isLoading: true));
    final user = UserRepository.i.value;
    final mate = Mate(name,
        userId: user!.id,
        colorValue:
            Colors.primaries[Random().nextInt(Colors.primaries.length)].value);

    if (FlatRepository.i.value != null) {
      // Check for other mates with the same name
      if (FlatRepository.i.value!.mates.any((m) => m.name == name))
        emit(ShouldSetName(hasError: true));

      await FlatRepository.i.update((flat) => flat..mates.add(mate));
    } else
      await FlatRepository.i
          .insert(Flat(mate: mate, commonSpaces: _defaultCommonSpaces));

    final flat = FlatRepository.i.value!;
    await UserRepository.i.update(user
      ..flatIds.add(flat.id)
      ..currentFlatId = flat.id);

    emit(Initialized());
  }

  List<CommonSpace> get _defaultCommonSpaces => [
        CommonSpace('Kitchen', color: Colors.amber, enabled: true),
        CommonSpace('Bathroom', color: Colors.cyan, enabled: true),
        CommonSpace('Entrance', color: Colors.deepPurpleAccent),
        CommonSpace('Living Room', color: Colors.deepOrange),
        CommonSpace('Bedroom', color: Colors.blue),
        CommonSpace('Terrace', color: Colors.pinkAccent),
      ];
}
