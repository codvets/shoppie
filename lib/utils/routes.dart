import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/screens/buyer/auth_landing.dart';
import 'package:shop_app/screens/buyer/home.dart';
import 'package:shop_app/screens/buyer/product_details.dart';

import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/seller/seller_home.dart';
import 'package:shop_app/screens/signup_screen.dart';

class Routes {
  static const authLanding = '/auth_landing';
  static const loginScreen = '/login_screen';
  static const home = '/home';
  static const signUp = '/sign_up';
  static const sellerHome = '/seller_home';
  static const productDetails = '/product_details';

  static Map<String, Widget Function(BuildContext)> appRoutes(
          BuildContext context) =>
      {
        authLanding: (context) => AuthLanding(),
        loginScreen: (context) => LoginScreen(),
        home: (context) => ChangeNotifierProvider(
              create: (context) => HomeNotifier(),
              child: Home(),
            ),
        signUp: (context) => SignUp(),
        sellerHome: (context) => ChangeNotifierProvider(
              create: (context) => HomeNotifier(),
              child: SellerHome(),
            ),
        productDetails: (context) => ChangeNotifierProvider.value(
              value: HomeNotifier(),
              child: ProductDetails(),
            )
      };
}
