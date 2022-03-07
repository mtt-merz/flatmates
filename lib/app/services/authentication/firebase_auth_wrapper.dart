import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseAuthWrapper extends AuthenticationService {
  Logger get _logger => Logger(runtimeType.toString());

  final FirebaseAuth _auth;

  FirebaseAuthWrapper() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((user) {
      _authStreamController.add(user?.uid);
      _logger.info(user != null ? 'User authenticated [${user.uid}]' : 'User NOT authenticated');
    });
  }

  @override
  Future<void> dispose() => _authStreamController.close();

  final BehaviorSubject<String?> _authStreamController = BehaviorSubject();

  @override
  Stream<String?> get onAuthenticationChanges => _authStreamController.stream;

  @override
  void signInAnonymously() => _auth.signInAnonymously().then(
      (credentials) => _logger.info('User registered anonymously [${credentials.user!.uid}]'));

  @override
  Future<void>? signOut() => _auth.signOut().then((value) => _logger.info('User signed out'));

  @override
  Future<void>? deleteAccount() =>
      _auth.currentUser?.delete().then((_) => _logger.info('Account deleted'));
}
