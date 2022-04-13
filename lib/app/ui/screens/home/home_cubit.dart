import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<AsyncSnapshot> {
  final _userRepository = Locator.get<UserRepository>();

  HomeCubit() : super(const AsyncSnapshot.waiting());

  String get flatName => 'My flat';
}
