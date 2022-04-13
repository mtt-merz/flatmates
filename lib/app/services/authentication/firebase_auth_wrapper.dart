import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flatmates/app/services/authentication/authentication_service.dart';
import 'package:logging/logging.dart';

class FirebaseAuthWrapper extends AuthenticationService {
  Logger get _logger => Logger(runtimeType.toString());

  final FirebaseAuth _auth;

  FirebaseAuthWrapper() : _auth = FirebaseAuth.instance;

  @override
  Future<void> dispose() async {}

  @override
  String? get currentUser => _auth.currentUser?.uid;

  @override
  Future<String> signAnonymously() => _auth.signInAnonymously().then((credential) {
        _logger.info('User signed (ANONYMOUS) [${credential.user!.uid}]');
        return credential.user!.uid;
      });

  @override
  Future<String> loginWithEmailAndPassword(String email, String password) async {
    if (_auth.currentUser != null) {
      assert(_auth.currentUser!.isAnonymous);
      await deleteAccount();
    }

    return _auth.signInWithEmailAndPassword(email: email, password: password).then((credential) {
      _logger.info('User logged (EMAIL+PASSWORD) [${credential.user!.uid}]');
      return credential.user!.uid;
    }).onError<FirebaseAuthException>((error, _) {
      log('Error while logging user (EMAIL+PASSWORD)', error: error);
      throw AuthenticationError(code: error.code, message: error.message);
    });
  }

  @override
  Future<String> registerWithEmailAndPassword(String email, String password,
      {bool updateAccount = false}) {
    if (_auth.currentUser != null) {
      assert(_auth.currentUser!.isAnonymous);
      return _auth.currentUser!
          .linkWithCredential(EmailAuthProvider.credential(email: email, password: password))
          .then((credential) {
        _logger.info('User account updated (EMAIL+PASSWORD) [${credential.user!.uid}]');
        return credential.user!.uid;
      }).onError<FirebaseAuthException>((error, _) {
        log('Error while updating user account (EMAIL+PASSWORD)', error: error);
        throw _parseError(error);
      });
    }

    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((credential) {
      _logger.info('User registered (EMAIL+PASSWORD) [${credential.user!.uid}]');
      return credential.user!.uid;
    }).onError<FirebaseAuthException>((error, _) {
      log('Error while registering user (EMAIL+PASSWORD)', error: error);
      throw _parseError(error);
    });
  }

  @override
  Future<void> signOut() => _auth.signOut().then((value) => _logger.info('User signed out'));

  @override
  Future<void> deleteAccount() async {
    if (_auth.currentUser == null) return;
    return _auth.currentUser!
        .delete()
        .then((_) => _logger.info('Account deleted'))
        .onError<FirebaseAuthException>((error, _) {
      log('Error while deleting user account', error: error);
      throw _parseError(error);
    });
  }

  AuthenticationError _parseError(FirebaseAuthException error) =>
      AuthenticationError(code: error.code, message: error.message);
}
