import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationService {
  Logger get _logger => Logger(runtimeType.toString());

  static AuthenticationService get instance => _instance ??= AuthenticationService._();
  static AuthenticationService? _instance;

  final FirebaseAuth _auth;

  AuthenticationService._() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((user) {
      _authStreamController.add(user?.uid);
      _logger.info(user != null ? 'User authenticated [${user.uid}]' : 'User NOT authenticated');
    });
  }

  /// Free all resources
  Future<void> dispose() async {
    await _authStreamController.close();
  }

  String? get userId => _auth.currentUser?.uid;

  final BehaviorSubject<String?> _authStreamController = BehaviorSubject();

  /// Inform listeners about changes on the authentication state
  Stream<String?> get authStream => _authStreamController.stream;

  /// Authenticate the user ANONYMOUSLY
  Future signInAnonymously() => _auth.signInAnonymously().then(
      (credentials) => _logger.info('User registered anonymously [${credentials.user!.uid}]'));

  /// Log out the user
  Future<void>? signOut() =>
      _auth.currentUser?.delete().then((value) => _logger.info('User signed out'));
}
