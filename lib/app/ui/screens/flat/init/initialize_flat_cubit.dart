import 'package:flatmates/app/models/flat/mate/mate.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

enum FlatState { regular, notFound, joining, generating }

class InitializeFlatCubit extends Cubit<AsyncSnapshot<FlatState>> {
  final _userRepository = GetIt.I<UserRepository>();
  final _flatRepository = GetIt.I<FlatRepository>();

  InitializeFlatCubit() : super(const AsyncSnapshot.waiting()) {
    _userRepository.data.then((user) async {
      if (user.flatId == null)
        return emit(const AsyncSnapshot.withData(ConnectionState.active, FlatState.notFound));

      await _flatRepository.load(user.flatId!);
      emit(const AsyncSnapshot.withData(ConnectionState.active, FlatState.regular));
    });
  }

  void joinFlat(String invitationCode) {}

  void createFlat() =>
      emit(const AsyncSnapshot.withData(ConnectionState.active, FlatState.generating));

  void setUsername(String username) async {
    final userId = (await _userRepository.data).id;
    switch (state.data) {
      case FlatState.generating:
        final flat = Flat(mate: Mate(userId, name: username));
        _flatRepository.insert(flat);
        _userRepository.update((user) => user..flatId = flat.id);
        break;
      case FlatState.joining:
        _flatRepository.update((flat) => flat..mates.add(Mate(userId, name: username)));
        break;
      default:
    }

    emit(const AsyncSnapshot.withData(ConnectionState.done, FlatState.regular));
  }
}
