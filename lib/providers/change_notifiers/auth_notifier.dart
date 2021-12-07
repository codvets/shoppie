import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/shoppie_user.dart';
import 'package:shop_app/repo/network.dart';

import 'package:shop_app/utils/routes.dart';

class AuthNotifier with ChangeNotifier {
  final Network _network = Network();
  void checkCurrentUser(BuildContext context) {
    if (_network.checkCurrentUser() == null) {
      Navigator.of(context).pushNamed(Routes.loginScreen);
    } else {
      Navigator.pushNamed(context, Routes.home);
    }
  }

  void login(BuildContext context,
      {required String email, required String password}) async {
    try {
      await _network.login(email: email, password: password);

      Navigator.of(context).pushNamed(Routes.home);
    } on FirebaseAuthException catch (error, stk) {
      print("ERROR OCCURED IN NETWORK FUNCTION: DISPLAYING IN PROVIDER");
    }
  }

  void register(BuildContext context,
      {required String name,
      required String email,
      required String password}) async {
    final ShoppieUser user = ShoppieUser(email: email, name: name);

    try {
      await _network.register(user: user, password: password);

      Navigator.pushNamed(context, Routes.home);
    } on FirebaseException catch (error, stk) {
      //TODO: Handle Exception
    }
  }
}
