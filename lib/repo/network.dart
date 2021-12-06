import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class Network {
  final firebaseAuth = FirebaseAuth.instance;

  User? checkCurrentUser() {
    return firebaseAuth.currentUser;
  }

  Future<User> login({required String email, required String password}) async {
    try {
      final UserCredential userCreds = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCreds.user!;
    } on FirebaseAuthException catch (error, stk) {
      print('An error occured during sign in: $error \n Stacktrace: $stk');
      throw FirebaseAuthException(code: error.code, message: error.message);
    }
  }
}
