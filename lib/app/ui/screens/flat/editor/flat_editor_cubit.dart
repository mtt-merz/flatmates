import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FlatEditorCubitState {}

class Editing extends FlatEditorCubitState {
  final Flat flat;

  final bool isLoading;
  final bool hasError;

  Editing(this.flat, {this.isLoading = false, this.hasError = false});
}

class FlatEditorCubit extends Cubit<FlatEditorCubitState> {
  FlatEditorCubit() : super(Editing(_flat));

  static final _flat = FlatRepository.i.value!;

  void setName(String name) => emit(Editing(_flat..name = name));

  void toggleCommonSpace(CommonSpace commonSpace) => emit(Editing(_flat
    ..commonSpaces
        .firstWhere((element) => commonSpace.name == element.name)
        .enabled = commonSpace.enabled));

  void save() {}
}
