import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/utils/routes.dart';

class Seller extends StatelessWidget {
  const Seller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.sellerProfile);
              },
              child: Text(
                "Profile",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.productEntry);
              },
              child: Text(
                "Product Entry",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.chat);
              },
              child: Text(
                "Chats",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<AuthNotifier>(context, listen: false)
                    .logout(context);
              },
              child: Text(
                "Log OUt",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
