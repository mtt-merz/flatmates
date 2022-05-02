import 'package:flatmates/app/repositories/chore_repository.dart';
import 'package:flatmates/app/repositories/expense_repository.dart';
import 'package:flatmates/app/repositories/flat_repository.dart';
import 'package:flatmates/app/repositories/repository.dart';
import 'package:flatmates/app/repositories/user_repository.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:flatmates/app/services/authentication/firebase_auth_wrapper.dart';
import 'package:flatmates/app/services/persistence/firestore_wrapper.dart';
import 'package:flatmates/app/services/persistence/persistence_service.dart';
import 'package:flatmates/app/services/service.dart';
import 'package:flatmates/app/ui/screens/authentication/authentication_cubit.dart';
import 'package:get_it/get_it.dart';

class Locator {
  static T get<T extends Object>() => GetIt.instance<T>();

  static final _getIt = GetIt.I;

  static void init() {
    // Services
    _registerService<AuthenticationService>(FirebaseAuthWrapper());
    _registerService<PersistenceService>(FirestoreWrapper());

    // Repositories
    _registerRepository(UserRepository());
    _registerRepository(FlatRepository());
    _registerRepository(ExpenseRepository());
    _registerRepository(ChoreRepository());

    _getIt.registerSingleton<AuthenticationCubit>(AuthenticationCubit(),
        dispose: (cubit) => cubit.close());
  }

  static void _registerRepository<R extends Repository>(R repository) =>
      _getIt.registerSingleton<R>(repository, dispose: (r) => r.close());

  static void _registerService<S extends Service>(S service) =>
      _getIt.registerSingleton<S>(service, dispose: (s) => s.dispose());
}
