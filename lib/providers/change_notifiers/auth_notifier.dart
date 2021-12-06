import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
}
