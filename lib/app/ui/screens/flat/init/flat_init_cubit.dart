import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FlatInitCubit extends Cubit<AsyncSnapshot<bool>> {
  final _userRepository = GetIt.I<UserRepository>();
  final _flatRepository = GetIt.I<FlatRepository>();

  FlatInitCubit() : super(const AsyncSnapshot.waiting()) {
    _flatRepository.stream.listen((flat) {});

    _userRepository.stream.listen((user) async {
      final flatId = user.flatId;
      if (flatId == null) return emit(const AsyncSnapshot.withData(ConnectionState.active, false));

      await _flatRepository.load(flatId);
      emit(const AsyncSnapshot.withData(ConnectionState.active, true));
    });
  }

  void joinFlat(String invitationCode) {}

  void createFlat() async {
    final flat = Flat();

    await _flatRepository.update(flat);
    await _userRepository.update((user) => user..flatId = flat.id);
  }
}
