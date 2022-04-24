import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SettingsCubitState {}

class Ready extends SettingsCubitState {}

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(Ready());

  User get _user => UserRepository.i.value!;

  void signOut() async {
    if (_user.isAnonymous) {
      UserRepository.i.remove();
      FlatRepository.i.removeMate(_user.id);
    }

    try {
      await Locator.get<AuthenticationService>().signOut();
    } on AuthenticationError catch (_) {}
  }

  void leaveFlat() {
    UserRepository.i.update(_user..flatIds.remove(_user.currentFlatId));
    FlatRepository.i.removeMate(_user.id);
  }

  void deleteAccount(
      {required Future<bool> Function() onRequiresRecentLogin}) async {
    try {
      await Locator.get<AuthenticationService>().deleteAccount();

      UserRepository.i.remove();
      FlatRepository.i.removeMate(_user.id);
    } on AuthenticationError catch (error) {
      if (error.code == 'requires-recent-login')
        onRequiresRecentLogin().then((value) => value
            ? deleteAccount(onRequiresRecentLogin: onRequiresRecentLogin)
            : null);
    }
  }
}
