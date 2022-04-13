import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileCubitState {}

class Ready extends ProfileCubitState {}

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit()
      : _flat = FlatRepository.i.value,
        super(Ready()) {
    FlatRepository.i.stream.listen((flat) {
      _flat = flat;
      emit(Ready());
    });
  }

  Mate get _mate => FlatRepository.i.loggedMate(_user.id)!;
  final _user = UserRepository.i.value!;
  late Flat _flat;

  Color get mateColor => Color(_mate.colorValue);

  String get mateName => _mate.name;

  bool get userIsAnonymous => _user.isAnonymous;

  void leaveFlat() {
    UserRepository.i.update(_user..flatIds.remove(_user.currentFlatId));
    _removeMate();
  }

  void deleteAccount({required Future<bool> Function() onRequiresRecentLogin}) async {
    try {
      await Locator.get<AuthenticationService>().deleteAccount();

      UserRepository.i.remove();
      _removeMate();
    } on AuthenticationError catch (error) {
      if (error.code == 'requires-recent-login')
        onRequiresRecentLogin().then(
            (value) => value ? deleteAccount(onRequiresRecentLogin: onRequiresRecentLogin) : null);
    }
  }

  void _removeMate() {
    _flat.mates.removeWhere((mate) => mate == _mate);
    _flat.mates.isEmpty ? FlatRepository.i.remove() : FlatRepository.i.update((flat) => flat);
  }
}
