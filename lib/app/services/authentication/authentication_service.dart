import 'dart:async';

import 'package:flatmates/app/services/service.dart';

abstract class AuthenticationService implements Service {
  /// Stream the id of the current user (null ifthe user is not authenticated)
  Stream<String?> get onAuthenticationChanges;

  /// Authenticate the user ANONYMOUSLY
  void signInAnonymously();

  /// Log out the user
  void signOut();

  /// Delete user account
  void deleteAccount();
}
