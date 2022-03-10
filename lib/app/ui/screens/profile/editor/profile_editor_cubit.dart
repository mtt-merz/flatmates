import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfileEditorCubit extends Cubit<Mate> {
  ProfileEditorCubit() : super(_mate.clone());

  static final Mate _mate = GetIt.I<FlatRepository>().value.mates.singleWhere(
        (mate) => mate.userId == GetIt.I<UserRepository>().value.id,
      );

  List<Color> get availableColors => ColorUtils.availableColors;

  void setName(String name) => _mate.name = name;

  void setColor(Color color) => emit(_mate
    ..colorValue = color.value
    ..clone());
}