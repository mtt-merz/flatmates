import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class SignCubitState {}

class Editing extends SignCubitState {
  final String? error;
  final bool isLoading;

  Editing({this.isLoading = false, this.error});
}

abstract class SignCubit extends Cubit<SignCubitState> {
  SignCubit() : super(Editing());

  final _userRepository = Locator.get<UserRepository>();
  final _flatRepository = Locator.get<FlatRepository>();

  final _auth = Locator.get<AuthenticationService>();

  Future<void> _updateUser(User oldUser) async {
    // Update user
    await _userRepository.updateFunctional(
      (user) => user
        ..currentFlatId = oldUser.currentFlatId ?? user.currentFlatId
        ..flatIds.addAll(oldUser.flatIds),
    );

    // Update mate in all flats
    for (String flatId in _userRepository.value!.flatIds) {
      await _flatRepository.fetch(flatId);
      await _flatRepository.updateMateUserId(oldUser.id, _userRepository.value!.id);
    }
  }
}

class SignUpCubit extends SignCubit {
  void registerWithEmailAndPassword({
    required String email,
    required String password,
    required String repeatPassword,
    required VoidCallback onSucceed,
  }) async {
    emit(Editing(isLoading: true));

    if (email.isEmpty || password.isEmpty || repeatPassword.isEmpty)
      return emit(Editing(error: 'empty-fields'));
    if (password != repeatPassword) return emit(Editing(error: 'passwords-not-matching'));

    try {
      final userId = await _auth.registerWithEmailAndPassword(email, password,
          updateAccount: _userRepository.hasValue);

      final oldUser = _userRepository.valueOrNull;
      await _userRepository.insert(User(userId, isAnonymous: false));

      if (oldUser != null) await _updateUser(oldUser);
      onSucceed();
    } on AuthenticationError catch (error) {
      return emit(Editing(error: error.code));
    }
  }
}

class SignInCubit extends SignCubit {
  void loginWithEmailAndPassword({
    required String email,
    required String password,
    required VoidCallback onSucceed,
  }) async {
    emit(Editing(isLoading: true));

    if (email.isEmpty || password.isEmpty) return emit(Editing(error: 'empty-fields'));

    try {
      final userId = await _auth.loginWithEmailAndPassword(email, password);

      final oldUser = _userRepository.valueOrNull;
      await _userRepository.fetch(userId);

      if (oldUser != null) await _updateUser(oldUser);
      onSucceed();
    } on AuthenticationError catch (error) {
      return emit(Editing(error: error.code));
    }
  }
}
