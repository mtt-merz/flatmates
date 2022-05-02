import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SettingsCubitState {}

class Ready extends SettingsCubitState {}

class RequireRecentLogin extends SettingsCubitState {}

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(Ready());

  final _user = UserRepository.i.value!;

  AuthenticationService get _authenticationService =>
      Locator.get<AuthenticationService>();

  void signOut() {
    if (_user.isAnonymous) return deleteAccount();
    _catchAuthenticationError(() => _authenticationService.signOut());
  }

  void leaveFlat() {
    UserRepository.i.leaveCurrentFlat();
    FlatRepository.i.removeMate(_user.id);
  }

  void deleteAccount() => _catchAuthenticationError(() async {
        await _authenticationService.deleteAccount();
        await UserRepository.i.remove();
      });

  Future<void> _catchAuthenticationError(Future<void> Function() code) async {
    try {
      await code();
    } on AuthenticationError catch (error) {
      switch (error.code) {
        case 'requires-recent-login':
          emit(RequireRecentLogin());
      }
    }
  }
}
