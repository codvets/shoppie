import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';

class SellerHome extends StatelessWidget {
  const SellerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Seller Home"),
        TextButton(
            onPressed: () {
              Provider.of<AuthNotifier>(context, listen: false).logout(context);
            },
            child: Text("LOGOUT")),
      ],
    )));
  }
}
