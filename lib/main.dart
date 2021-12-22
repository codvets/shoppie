import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/shop_app.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthNotifier>(
          create: (BuildContext context) {
            return AuthNotifier();
          },
        ),
        Provider<HomeNotifier>(
          create: (BuildContext context) {
            return HomeNotifier();
          },
        ),
      ],
      child: ShopApp(),
    ),
  );
}
