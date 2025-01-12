import 'package:firebase_auth/firebase_auth.dart';

class RegisterFailure implements Exception {
  const RegisterFailure([this.message = 'An unknown exception occured.']);
  final String message;

  factory RegisterFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return RegisterFailure('Email is not valid or badly formatted.');
      case 'user-disabled':
        return const RegisterFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const RegisterFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const RegisterFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'weak-password':
        return const RegisterFailure(
          'Please enter a stronger password.',
        );
      default:
        return const RegisterFailure();
    }
  }
}

class LoginFailure implements Exception {
  const LoginFailure([this.message = 'An unknown exception occured.']);
  final String message;

  factory LoginFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LoginFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const LoginFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LoginFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const LoginFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LoginFailure();
    }
  }
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw RegisterFailure.fromCode(e.code);
    } catch (_) {
      throw const RegisterFailure();
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw LoginFailure.fromCode(e.code);
    } catch (_) {
      throw const LoginFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw LogOutFailure();
    }
  }
}
