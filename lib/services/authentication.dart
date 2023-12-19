import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthenticationInfo {
  final bool success;
  final String? errorMessage;

  AuthenticationInfo({
    required this.success,
    this.errorMessage,
  });
}

class Authentication {
  bool _validateUserEmail(String email) {
    return email.contains('@');
  }

  Future<AuthenticationInfo> signIn(String email, String password) async {
    try {
      if (!_validateUserEmail(email)) {
        Logger().log(Level.info, 'Invalid email address.');
        return AuthenticationInfo(success: false, errorMessage: 'Invalid email address.');
      }
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Logger().log(Level.info, 'User ${userCredential.user!.uid} signed in.');
      return AuthenticationInfo(success: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().log(Level.info, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().log(Level.info, 'Wrong password provided for that user.');
      } else {
        Logger().log(Level.info, e.code);
      }

      return AuthenticationInfo(success: false, errorMessage: e.code);
    } catch (e) {
      Logger().log(Level.error, e.toString());
      return AuthenticationInfo(success: false, errorMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<AuthenticationInfo> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Logger().log(Level.info, 'User ${userCredential.user!.uid} signed up.');
      return AuthenticationInfo(success: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().log(Level.info, 'The password provided is too weak.');
        return AuthenticationInfo(success: false, errorMessage: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().log(Level.info, 'The account already exists for that email.');
        return AuthenticationInfo(success: false, errorMessage: 'The account already exists for that email.');
      } else {
        Logger().log(Level.info, e.code);
        return AuthenticationInfo(success: false, errorMessage: e.code);
      }
    } catch (e) {
      Logger().log(Level.info, e.toString());
      return AuthenticationInfo(success: false, errorMessage: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
      Logger().log(Level.info, 'User ${userCredential.user!.uid} signed in with Google.');
    } catch (e) {
      Logger().log(Level.error, e.toString());
    }
  }
}
