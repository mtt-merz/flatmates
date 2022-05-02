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

  AuthenticationCubit() : super(Loading()) {
    UserRepository.i.stream.listen((userId) =>
        emit(userId == null ? NotAuthenticated() : Authenticated()));

    final userId = _authentication.currentUser;
    if (userId != null)
      sign(userId);
    else
      emit(NotAuthenticated());
  }

  void signInAnonymously() async {
    emit(NotAuthenticated(isLoading: true));

    final userId = await _authentication.signAnonymously();
    await UserRepository.i.fetch(userId).onError((error, stackTrace) {
      final user = User(userId, isAnonymous: true);
      return UserRepository.i.insert(user);
    });

    emit(Authenticated());
  }

  void sign(String userId) async {
    emit(Loading());
    await UserRepository.i.fetch(userId);

    emit(Authenticated());
  }

  void signOut() async {
    await _authentication.signOut();
    emit(NotAuthenticated());
  }
}
