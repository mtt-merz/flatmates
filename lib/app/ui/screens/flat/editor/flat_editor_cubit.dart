import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetFlatState {
  final Flat flat;

  final bool isLoading;
  final bool hasError;

  final bool hasChanges;

  SetFlatState(
    this.flat, {
    this.isLoading = false,
    this.hasError = false,
    this.hasChanges = false,
  });
}

class SetFlatCubit extends Cubit<SetFlatState> {
  final Flat _flat;
  late final _originalFlat = _flat.clone();

  SetFlatCubit()
      : _flat = FlatRepository.i.value!,
        super(SetFlatState(FlatRepository.i.value!));

  void setName(String name) =>
      emit(SetFlatState(_flat..name = name.trim().isNotEmpty ? name : null,
          hasChanges: _flat != _originalFlat));

  void toggleCommonSpace(CommonSpace commonSpace) {
    _flat.commonSpaces.contains(commonSpace)
        ? _flat.commonSpaces.remove(commonSpace)
        : _flat.commonSpaces.add(commonSpace);

    emit(SetFlatState(_flat));
  }

  Future<void> save() {
    emit(SetFlatState(_flat, isLoading: true));
    return FlatRepository.i.update(_flat);
  }


}
