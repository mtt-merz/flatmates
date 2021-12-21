import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:rxdart/rxdart.dart';

class AuthenticationService {
  static final AuthenticationService instance = AuthenticationService._();

  final FirebaseAuth _auth;

  AuthenticationService._() : _auth = FirebaseAuth.instance {
    _auth
        .authStateChanges()
        .listen((user) => _authStreamController.add(user != null));
  }

  /// Free all resources
  Future<void> dispose() async {
    await _authStreamController.close();
  }

  String get userId => _auth.currentUser!.uid;

  final BehaviorSubject<bool> _authStreamController = BehaviorSubject();

  /// Inform listeners about changes on the authentication state
  Stream<bool> get onAuthEvent => _authStreamController.stream;

  /// Authenticate the user ANONYMOUSLY
  Future signInAnonymously() => _auth.signInAnonymously();

  /// Log out the user
  Future<void>? signOut() => _auth.currentUser?.delete();
}
