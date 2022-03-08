import 'package:bloc/bloc.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationCubit extends Cubit<AsyncSnapshot<bool>> {
  final _authentication = GetIt.I<AuthenticationService>();

  AuthenticationCubit() : super(const AsyncSnapshot.waiting()) {
    _authentication.onAuthenticationChanges.listen((userId) async {
      if (userId == null) return emit(const AsyncSnapshot.withData(ConnectionState.active, false));

      GetIt.I<UserRepository>().load(userId);
      emit(const AsyncSnapshot.withData(ConnectionState.active, true));
    });
  }

  void signInAnonymously() => _authentication.signInAnonymously();

  void signIn() {}

  void signOut() => _authentication.signOut();
}
