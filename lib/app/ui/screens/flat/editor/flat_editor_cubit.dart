import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlatEditorCubit extends Cubit<Flat?> {
  late Flat flat;

  FlatEditorCubit() : super(null) {
    flat = FlatRepository.i.value;
    emit(flat);
  }

  void setName(String name) {
    if (name.isEmpty) return;
    emit(flat..name = name);
  }

  void setCommonSpaces(List<CommonSpace>? commonSpaces) {
    if (commonSpaces == null) return;
    emit(flat..commonSpaces = commonSpaces);
  }

  void save() {}
}
