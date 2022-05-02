import 'package:flatmates/app/models/chore/chore.dart';
import 'package:flatmates/app/repositories/chore_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChoresCubitState {}

class Loading extends ChoresCubitState {}

class Loaded extends ChoresCubitState {
  final List<Chore> chores;

  Loaded(this.chores);
}

class ChoresCubit extends Cubit<ChoresCubitState> {
  ChoresCubit() : super(Loading()) {
    ChoreRepository.i.stream.listen((chores) => emit(Loaded(chores)));
  }

  Future<void> refresh() => ChoreRepository.i.reload();
}
