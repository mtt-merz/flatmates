import 'package:bloc/bloc.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/locator.dart';

abstract class AuthenticationCubitState {}

class Loading extends AuthenticationCubitState {}

class NotAuthenticated extends AuthenticationCubitState {
  final bool isLoading;
  final AuthenticationError? error;

  NotAuthenticated({this.isLoading = false, this.error});
}

class Authenticated extends AuthenticationCubitState {}

class AuthenticationCubit extends Cubit<AuthenticationCubitState> {
  final _authentication = Locator.get<AuthenticationService>();
  final _userRepository = Locator.get<UserRepository>();

  AuthenticationCubit() : super(Loading()) {
    // _authentication.deleteAccount().then((value) {
    _userRepository.stream
        .listen((user) => emit(user != null ? Authenticated() : NotAuthenticated()));

    final userId = _authentication.currentUser;
    if (userId != null)
      _userRepository.fetch(userId);
    else
      emit(NotAuthenticated());
    // });
  }

  void signInAnonymously() async {
    emit(NotAuthenticated(isLoading: true));

    final userId = await _authentication.signAnonymously();
    await _userRepository.fetch(userId).onError((error, stackTrace) {
      final user = User(userId, isAnonymous: true);
      return _userRepository.insert(user);
    });

    emit(Authenticated());
  }

  void signOut() async {
    await _authentication.signOut();
    emit(NotAuthenticated());
  }
}
