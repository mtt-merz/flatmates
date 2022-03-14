import 'dart:async';

import 'package:flatmates/app/services/service.dart';

abstract class AuthenticationService implements Service {
  /// Stream the current authentication state:
  ///   - TRUE -> user authenticated
  ///   - FALSE -> user not authenticated
  Stream<bool> get stream;

  String? get currentUserId;

  /// Authenticate the user ANONYMOUSLY
  Future<String> signInAnonymously();

  /// Authenticate the user with EMAIL and PASSWORD
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> signUpWithEmailAndPassword(String email, String password);

  /// Log out the user
  Future<void>? signOut();

  /// Delete user profile
  Future<void>? deleteAccount();
}
