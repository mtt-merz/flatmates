import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeCubit extends Cubit<AsyncSnapshot> {
  final _userRepository = GetIt.I<UserRepository>();

  HomeCubit() : super(const AsyncSnapshot.waiting());

  void logout() async {
    final user = await _userRepository.data;
    await GetIt.I<FlatRepository>().disconnectMate(user.id);
    await _userRepository.remove();

    GetIt.I<AuthenticationService>().deleteAccount();
  }

  String get flatName => 'My flat';
}
