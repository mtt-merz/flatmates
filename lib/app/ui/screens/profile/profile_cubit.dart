import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProfileCubitState {}

class Ready extends ProfileCubitState {}

class ProfileCubit extends Cubit<ProfileCubitState> {
  ProfileCubit() : super(Ready()) {
    FlatRepository.i.stream.listen((flat) => emit(Ready()));
  }

  final User _user = UserRepository.i.value!;
  late final Mate _mate = FlatRepository.i.loggedMate(_user.id)!;

  Color get mateColor => Color(_mate.colorValue);

  String get mateName => _mate.name;

  String? get mateSurname => _mate.surname;

  bool get userIsAnonymous => _user.isAnonymous;

  void updateMate(Mate? mate) {
    if (mate == null) return;
    FlatRepository.i.updateMate(mate);
  }
}
