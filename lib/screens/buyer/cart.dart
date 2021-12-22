import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    log("CART SCREEN ${Provider.of<HomeNotifier>(context, listen: false).cartProducts.length.toString()}");
    return Scaffold(
      body: Consumer<HomeNotifier>(builder: (context, provider, _) {
        return ListView.builder(
          itemCount: provider.cartProducts.length,
          itemBuilder: (context, index) {
            final product = provider.cartProducts[index];
            return ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image: NetworkImage(product.image),
                    height: 50,
                    width: 50,
                  ),
                  Text(product.price.toString()),
                ],
              ),
              title: Text(product.title),
              subtitle: Text(product.description),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  provider
                      .deleteProductFromCart(product.id)
                      .then((value) => setState(() {}));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
