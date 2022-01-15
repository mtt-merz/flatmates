import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class InitCubitState {}

class Loading extends InitCubitState {}

class Running extends InitCubitState {}

class ShouldInitializeFlat extends InitCubitState {}

class InitCubit extends Cubit<InitCubitState> {
  InitCubit() : super(Loading()) {
    UserRepository.instance.data.then((user) async {
      if (user.flat.isEmpty) return emit(ShouldInitializeFlat());

      await FlatRepository.init(user.flat);
      return emit(Running());
    });
  }

  void createFlat() async {
    final flat = Flat();
    await FlatRepository.create(flat);

    final user = await UserRepository.instance.data;
    UserRepository.instance.update(user..flat = flat.id);

    emit(Running());
  }

  void joinFlat(String code) {}
}
