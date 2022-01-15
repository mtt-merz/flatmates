import 'package:bloc/bloc.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication_service.dart';

/// ### STATES ###
abstract class AuthenticationState {}

class Loading extends AuthenticationState {}

class Authenticated extends AuthenticationState {}

class NotAuthenticated extends AuthenticationState {}

/// ### BLOC ###
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(Loading()) {
    AuthenticationService.instance.authStream.listen((String? userId) async {
      if (userId == null) return emit(NotAuthenticated());

      await UserRepository.init(userId);
      return emit(Authenticated());
    });
  }

  void signInAnonymously() => AuthenticationService.instance.signInAnonymously();

  void signOut() => AuthenticationService.instance.signOut();
}
