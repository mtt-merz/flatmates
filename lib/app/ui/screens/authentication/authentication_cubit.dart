import 'package:bloc/bloc.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:get_it/get_it.dart';

abstract class AuthenticationCubitState {}

class Loading extends AuthenticationCubitState {}

class NotAuthenticated extends AuthenticationCubitState {
  final bool isLoading;
  final bool hasError;

  NotAuthenticated({this.isLoading = false, this.hasError = false});
}

class Authenticated extends AuthenticationCubitState {}

class AuthenticationCubit extends Cubit<AuthenticationCubitState> {
  final _authentication = GetIt.I<AuthenticationService>();
  final _userRepository = GetIt.I<UserRepository>();

  AuthenticationCubit() : super(Loading()) {
    _authentication.stream.listen((authenticated) async {
      if (!authenticated) return emit(NotAuthenticated());

      emit(NotAuthenticated(isLoading: true));
      final userId = _authentication.currentUserId!;
      await _userRepository.init(userId).onError((error, stackTrace) {
        final user = User(userId, isAnonymous: true);
        return _userRepository.insert(user);
      });
      emit(Authenticated());
    });
  }

  void signInAnonymously() {
    emit(NotAuthenticated(isLoading: true));
    _authentication.signInAnonymously();
  }

  void signIn() {}

  void signOut() => _authentication.signOut();
}
