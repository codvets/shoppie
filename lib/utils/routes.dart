import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth_landing.dart';
import 'package:shop_app/screens/home.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/signup_screen.dart';

class Routes {
  static const authLanding = '/auth_landing';
  static const loginScreen = '/login_screen';
  static const home = '/home';
  static const signUp = '/sign_up';

  static Map<String, Widget Function(BuildContext)> appRoutes(
          BuildContext context) =>
      {
        authLanding: (context) => AuthLanding(),
        loginScreen: (context) => LoginScreen(),
        home: (context) => Home(),
        signUp: (context) => SignUp()
      };
}
