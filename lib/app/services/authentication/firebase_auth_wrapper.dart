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
      _streamController.add(user != null);
      _logger.info(user != null ? 'User authenticated [${user.uid}]' : 'User NOT authenticated');
    });
  }

  @override
  Future<void> dispose() => _streamController.close();

  @override
  Stream<bool> get stream => _streamController.stream;
  final BehaviorSubject<bool> _streamController = BehaviorSubject();

  @override
  String? get currentUserId => _auth.currentUser?.uid;

  @override
  Future<String> signInAnonymously() => _auth.signInAnonymously().then((credentials) {
        _logger.info('User registered anonymously [${credentials.user!.uid}]');
        return credentials.user!.uid;
      });

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password).then((credentials) {
        _logger.info('User signed with username and password [${credentials.user!.uid}]');
        return credentials.user!.uid;
      });

  @override
  Future<String> signUpWithEmailAndPassword(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password).then((credentials) {
        _logger.info('User registered with username and password [${credentials.user!.uid}]');
        return credentials.user!.uid;
      });

  @override
  Future<void>? signOut() => _auth.signOut().then((value) => _logger.info('User signed out'));

  @override
  Future<void>? deleteAccount() =>
      _auth.currentUser?.delete().then((_) => _logger.info('Account deleted'));
}
