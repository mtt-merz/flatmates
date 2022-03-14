import 'dart:developer';

import 'package:flatmates/app/models/user/user.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class SignCubitState {}

class Loading extends SignCubitState {}

class Editing extends SignCubitState {
  final bool canSubmit;
  final bool hasError;

  Editing({required this.canSubmit, this.hasError = false});
}

class SignCubit extends Cubit<SignCubitState> {
  SignCubit() : super(Editing(canSubmit: false));

  String _email = '';
  String _password = '';
  String _repeatPassword = '';

  set mail(String mail) {
    _email = mail;
    _activateConfirmButton();
  }

  set password(String password) {
    _password = password;
    _activateConfirmButton();
  }

  set repeatPassword(String repeatPassword) {
    _repeatPassword = repeatPassword;
    _activateConfirmButton();
  }

  void _activateConfirmButton() {
    bool canSubmit = _email.isNotEmpty && _password.isNotEmpty && _repeatPassword.isNotEmpty;
    emit(Editing(canSubmit: canSubmit));
  }

  void submit(void Function() onSucceed) async {
    emit(Loading());
    try {
      if (_password.length < 6) throw Exception();
      if (_password != _repeatPassword) throw Exception();

      final userId =
          await GetIt.I<AuthenticationService>().signUpWithEmailAndPassword(_email, _password);
      final user = User(userId, isAnonymous: false, flatId: GetIt.I<FlatRepository>().value.id);
      await GetIt.I<UserRepository>().update(user);

      onSucceed();
    } on Object catch (e, s) {
      log('Sign up error', error: e, stackTrace: s);
      emit(Editing(canSubmit: true, hasError: true));
    }
  }
}
