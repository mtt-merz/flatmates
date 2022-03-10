import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeCubit extends Cubit<AsyncSnapshot> {
  final _userRepository = GetIt.I<UserRepository>();

  HomeCubit() : super(const AsyncSnapshot.waiting());

  String get flatName => 'My flat';
}
