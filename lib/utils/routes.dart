import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/providers/chats_provider.dart';
import 'package:shop_app/screens/buyer/auth_landing.dart';
import 'package:shop_app/screens/buyer/cart.dart';
import 'package:shop_app/screens/buyer/home.dart';
import 'package:shop_app/screens/buyer/product_details.dart';
import 'package:shop_app/screens/chats.dart';
import 'package:shop_app/screens/conversation.dart';

import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/seller/product_entry.dart';
import 'package:shop_app/screens/seller/seller.dart';
import 'package:shop_app/screens/seller/seller_profile.dart';
import 'package:shop_app/screens/signup_screen.dart';

class Routes {
  //BUYER
  static const home = '/home';
  static const productDetails = '/product_details';
  static const cart = '/cart';

  //COMMON
  static const chat = '/chat';
  static const signUp = '/sign_up';
  static const authLanding = '/auth_landing';
  static const loginScreen = '/login_screen';
  static const conversation = '/conversation';

  //SELLER
  static const sellerHome = '/seller_home';
  static const sellerProfile = '/seller_profile';
  static const productEntry = '/product_entry';

  static Map<String, Widget Function(BuildContext)> appRoutes(
          BuildContext context) =>
      {
        authLanding: (context) => AuthLanding(),
        loginScreen: (context) => LoginScreen(),
        home: (context) => Home(),
        signUp: (context) => SignUp(),
        sellerHome: (context) => Seller(),
        productDetails: (context) => ProductDetails(),
        cart: (context) => Cart(),
        sellerProfile: (context) => SellerProfile(),
        productEntry: (context) => ProductEntry(),
        chat: (context) => ChangeNotifierProvider(
            create: (context) => ChatProvider(), child: Chats()),
        conversation: (context) => Conversation(),
      };
}
