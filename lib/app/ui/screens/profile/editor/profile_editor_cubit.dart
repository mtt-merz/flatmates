import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditorCubit extends Cubit<Mate?> {
  late Mate mate;

  ProfileEditorCubit() : super(null) {
    final userId = UserRepository.i.value!.id;
    mate = FlatRepository.i.loggedMate(userId)!;

    emit(mate);
  }

  List<Color> get availableColors => ColorUtils.availableColors..removeAt(0);

  void setName(String name) => mate = mate.copyWith(name: name);

  void setSurname(String surname) => mate = mate.copyWith(surname: surname);

  void setColor(Color color) {
    mate = mate.copyWith(colorValue: color.value);
    emit(mate);
  }

  Future<void> save() {
    return FlatRepository.i.updateMate(mate);
  }
}
