import 'dart:async';

import 'package:flatmates/app/services/service.dart';

abstract class AuthenticationService implements Service {
  String? get currentUser;

  /// Authenticate the user ANONYMOUSLY
  Future<String> signAnonymously();

  /// Authenticate the user with EMAIL and PASSWORD
  Future<String> loginWithEmailAndPassword(String email, String password);

  /// Register the user with EMAIL and PASSWORD
  Future<String> registerWithEmailAndPassword(String email, String password, {bool updateAccount = false});

  /// Log out the user
  Future<void> signOut();

  /// Delete user profile
  Future<void> deleteAccount();
}

class AuthenticationError {
  final String code;
  final String? message;

  AuthenticationError({required this.code, this.message});
}

