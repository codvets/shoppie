import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/models/shoppie_user.dart';

class Network {
  final firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<ShoppieUser> register(
      {required ShoppieUser user, required String password}) async {
    try {
      final UserCredential creds =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email, password: password);
      await firestore
          .collection("users")
          .doc(creds.user!.uid)
          .set(user.toJson());
      return user;
    } on FirebaseException catch (error, stk) {
      throw FirebaseException(plugin: "Firebase", message: "Error: $error");
    }
  }
}
