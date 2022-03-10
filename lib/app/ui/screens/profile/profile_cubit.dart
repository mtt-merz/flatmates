import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileCubit extends Cubit<AsyncSnapshot> {
  final _flatRepository = GetIt.I<FlatRepository>();
  final _userRepository = GetIt.I<UserRepository>();

  ProfileCubit() : super(const AsyncSnapshot.withData(ConnectionState.active, true));

  final _user = GetIt.I<UserRepository>().value;
  final _flat = GetIt.I<FlatRepository>().value;

  Mate get _mate => _flat.mates.singleWhere((element) => element.userId == _user.id);

  Color get mateColor => Color(_mate.colorValue);

  String get mateName => _mate.name;

  void leaveFlat() {
    _userRepository.update(_user..flatId = null);
    _removeMate();
  }

  void deleteAccount() {
    GetIt.I<AuthenticationService>().deleteAccount();

    _userRepository.remove();
    _removeMate();
  }

  void _removeMate() {
    _flat.mates.removeWhere((mate) => mate == _mate);
    _flat.mates.isEmpty ? _flatRepository.remove() : _flatRepository.update((flat) => flat);
  }
}
