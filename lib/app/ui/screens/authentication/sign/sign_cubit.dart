import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignCubitState {}

class Editing extends SignCubitState {
  final String? error;
  final bool isLoading;

  Editing({this.isLoading = false, this.error});
}

abstract class SignCubit extends Cubit<SignCubitState> {
  SignCubit() : super(Editing());

  final _auth = Locator.get<AuthenticationService>();

  Future<void> _updateUser(User oldUser) async {
    // Update user
    await UserRepository.i.updateFunctional(
      (user) => user
        ..currentFlatId = oldUser.currentFlatId ?? user.currentFlatId
        ..flatIds.addAll(oldUser.flatIds),
    );

    // Update mate in all flats
    for (String flatId in UserRepository.i.value!.flatIds) {
      await FlatRepository.i.fetch(flatId);
      await FlatRepository.i
          .updateMateUserId(oldUser.id, UserRepository.i.value!.id);
    }
  }
}

class SignUpCubit extends SignCubit {
  void registerWithEmailAndPassword({
    required String email,
    required String password,
    required String repeatPassword,
    required void Function(String) onSucceed,
  }) async {
    emit(Editing(isLoading: true));

    if (email.isEmpty || password.isEmpty || repeatPassword.isEmpty)
      return emit(Editing(error: 'empty-fields'));
    if (password != repeatPassword)
      return emit(Editing(error: 'passwords-not-matching'));

    try {
      final userId = await _auth.registerWithEmailAndPassword(email, password,
          updateAccount: UserRepository.i.hasValue);

      final oldUser = UserRepository.i.value;
      await UserRepository.i.insert(User(userId, isAnonymous: false));

      if (oldUser != null) await _updateUser(oldUser);
      onSucceed(userId);
    } on AuthenticationError catch (error) {
      return emit(Editing(error: error.code));
    }
  }
}

class SignInCubit extends SignCubit {
  void loginWithEmailAndPassword({
    required String email,
    required String password,
    required void Function(String) onSucceed,
  }) async {
    emit(Editing(isLoading: true));

    if (email.isEmpty || password.isEmpty)
      return emit(Editing(error: 'empty-fields'));

    try {
      final userId = await _auth.loginWithEmailAndPassword(email, password);

      final oldUser = UserRepository.i.value;
      await UserRepository.i.fetch(userId);

      if (oldUser != null) await _updateUser(oldUser);
      onSucceed(userId);
    } on AuthenticationError catch (error) {
      return emit(Editing(error: error.code));
    }
  }
}
