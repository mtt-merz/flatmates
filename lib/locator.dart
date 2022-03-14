import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/app/services/authentication/firebase_auth_wrapper.dart';
import 'package:flatmates/app/services/persistence/firestore_wrapper.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:flatmates/app/services/service.dart';
import 'package:flatmates/app/ui/screens/authentication/authentication_cubit.dart';
import 'package:flatmates/app/ui/screens/authentication/sign/sign_cubit.dart';
import 'package:flatmates/app/ui/screens/expenses/expense_adder/expense_adder_cubit.dart';
import 'package:flatmates/app/ui/screens/flat/flat_cubit.dart';
import 'package:flatmates/app/ui/screens/home/home_cubit.dart';
import 'package:flatmates/app/ui/screens/init/init_cubit.dart';
import 'package:flatmates/app/ui/screens/profile/editor/profile_editor_cubit.dart';
import 'package:flatmates/app/ui/screens/profile/profile_cubit.dart';
import 'package:get_it/get_it.dart';

class Locator {
  static void init() => GetIt.I.registerSingleton(Locator._());

  final _getIt = GetIt.I;

  Locator._() {
    // Services
    _registerService<AuthenticationService>(FirebaseAuthWrapper());
    _registerService<PersistenceService>(FirestoreWrapper());

    // Repositories
    _registerRepository(UserRepository());
    _registerRepository(FlatRepository());

    _registerCubits();
  }

  void _registerCubits() {
    _getIt.registerSingleton<AuthenticationCubit>(AuthenticationCubit(),
        dispose: (cubit) => cubit.close());

    _getIt.registerFactory(() => FlatCubit());
    _getIt.registerFactory(() => InitCubit());
    _getIt.registerFactory(() => ProfileEditorCubit());
    _getIt.registerFactory(() => HomeCubit());
    _getIt.registerFactory(() => ExpenseAdderCubit());
    _getIt.registerFactory(() => ProfileCubit());
    _getIt.registerFactory(() => SignCubit());
  }

  void _registerRepository<R extends Repository>(R repository) =>
      _getIt.registerSingleton<R>(repository, dispose: (r) => r.close());

  void _registerService<S extends Service>(S service) =>
      _getIt.registerSingleton<S>(service, dispose: (s) => s.dispose());
}
