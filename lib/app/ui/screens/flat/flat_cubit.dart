import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FlatCubitState {}

class Loading extends FlatCubitState {}

class Show extends FlatCubitState {
  final Flat flat;

  Show(this.flat);
}

class Updated extends FlatCubitState {
  final Flat flat;

  Updated(this.flat);
}

class FlatCubit extends Cubit<FlatCubitState> {
  late final Flat _flat;

  FlatCubit() : super(Loading());

  void save() {}

  void setName(String name) {
    if (name.isEmpty) return;
    emit(Show(_flat..name = name));
  }

  void setCommonSpaces(List<CommonSpace>? commonSpaces) {
    if (commonSpaces == null) return;
    emit(Show(_flat..commonSpaces = commonSpaces));
  }
}
