import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/shoppie_user.dart';
import 'package:shop_app/repo/network.dart';

import 'package:shop_app/utils/routes.dart';

class AuthNotifier with ChangeNotifier {
  final Network _network = Network();

  late ShoppieUser currentUser;
  void checkCurrentUser(BuildContext context) async {
    try {
      currentUser = await _network.checkCurrentUser();
      if (currentUser.type == UserType.seller) {
        Navigator.of(context).pushReplacementNamed(Routes.sellerHome);
      } else {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    } on FirebaseException catch (error, stk) {
      log("Error code: ${error.code}, Message: ${error.message}");
      Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
    }
  }

  void login(BuildContext context,
      {required String email, required String password}) async {
    try {
      currentUser = await _network.login(email: email, password: password);
      if (currentUser.type == UserType.seller) {
        Navigator.of(context).pushReplacementNamed(Routes.sellerHome);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      }
    } on FirebaseAuthException catch (error, stk) {
      print("ERROR OCCURED IN NETWORK FUNCTION: DISPLAYING IN PROVIDER");
    }
  }

  void register(BuildContext context,
      {required String name,
      required String email,
      required String password}) async {
    final ShoppieUser user =
        ShoppieUser(email: email, name: name, type: UserType.buyer, uid: "");

    try {
      currentUser = await _network.register(user: user, password: password);

      Navigator.pushReplacementNamed(context, Routes.home);
    } on FirebaseException catch (error, stk) {
      //TODO: Handle Exception
    }
  }

  void logout(BuildContext context) {
    FirebaseAuth.instance.signOut();

    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
  }
}
