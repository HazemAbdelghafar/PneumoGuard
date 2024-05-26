import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(milliseconds: 50));
      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Error code: ${e.code}');
      } // Print the error code
      String message = '';
      if (e.code == 'invalid-credential') {
        message =
            "The credentials are invalid. Please sign up if you don't have an account or try again";
      } else if (e.code == 'user-not-found') {
        message = 'An account does not exist for this email. Please sign up.';
      } else if (e.code == 'wrong-password') {
        message = 'The password provided is wrong.';
      } else {
        message = 'An error occurred. Please try again later.';
      }
      // var error = e;
      // log(error as String);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await user?.updateDisplayName(name);

      await Future.delayed(const Duration(milliseconds: 50));
      Navigator.pushNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else {
        message = 'An error occurred. Please try again later.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    await _auth.signOut();
    Navigator.pushNamed(context, '/welcome');
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
