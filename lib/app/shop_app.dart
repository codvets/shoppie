import 'package:flutter/material.dart';
import 'package:shop_app/utils/routes.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.authLanding,
      routes: Routes.appRoutes(context),
    );
  }
}
