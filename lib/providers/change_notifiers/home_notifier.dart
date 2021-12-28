import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/message.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/shoppie_user.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/repo/network.dart';
import 'package:shop_app/screens/conversation.dart';
import 'package:shop_app/utils/routes.dart';

class HomeNotifier with ChangeNotifier {
  Category selectedCategory = Category.shoes;

  Network _network = Network();

  void changeCategory(Category category) {
    selectedCategory = category;

    notifyListeners();
  }

  List<Product> cartProducts = List.empty(growable: true);

  List<Product> products = List.empty(growable: true);

  void changeQuantity(int quantity, String productId) {
    final indexOfProduct =
        cartProducts.indexWhere((element) => element.id == productId);
    final product = cartProducts[indexOfProduct];

    product.quantity = quantity;

    cartProducts.removeAt(indexOfProduct);
    cartProducts.insert(indexOfProduct, product);
    notifyListeners();
  }

  Future<void> uploadProduct(
    BuildContext context, {
    required File image,
    required String title,
    required String description,
    required double price,
    required String category,
    int? discount,
    required String sellerId,
  }) async {
    Product product = Product(
        image: "",
        title: title,
        description: description,
        price: price,
        discount: discount,
        category: category,
        sellerId: sellerId,
        id: "");

    await _network.uploadProduct(product, image);
  }

  Future<List<Product>> getProducts(Category category) async {
    return await _network.getProducts(category);
  }

  Future<void> favorizeProduct(Product product, String uid) async {
    await _network.favorizeProduct(product, uid);
  }

  Future<void> addToCart(Product product, String uid) async {
    product.quantity = 1;
    await _network.addToCart(product, uid);
  }

  Stream<List<Product>> getCartProducts(String uid) {
    return _network.getCartProducts(uid);
  }

  Future<void> deleteProductFromCart(String productId) async {
    log('BEFORE DELETE: ${cartProducts.length}');
    await _network.deleteProductFromCart(productId: productId).then((value) {
      cartProducts.removeWhere((element) => element.id == productId);
      notifyListeners();
    });
  }

  void populateCart(List<Product> cartItems) {
    cartProducts.clear();
    cartItems.forEach((element) {
      element.quantity = 1;
      cartProducts.add(element);
    });

    notifyListeners();
  }

  Future<void> buyProductsFromCart() async {
    await _network.buyProductsFromCart(cartProducts);
  }

  Future<void> chatWithSeller(BuildContext context,
      {required String sellerId}) async {
    final chatId = await _network.getChatId(sellerId: sellerId);

    Navigator.of(context).pushNamed(
      Routes.conversation,
      arguments: ChatArgs(sellerId: sellerId, chatId: chatId!),
    );
  }

  Future<void> sendMessage(context,
      {required String chatId,
      required String sellerId,
      required String message}) async {
    final currentUser =
        Provider.of<AuthNotifier>(context, listen: false).currentUser;
    final msg = Message(
        sentTime: Timestamp.fromDate(DateTime.now()),
        senderId: currentUser.uid,
        senderName: currentUser.name,
        receiverId: sellerId,
        body: message);

    await _network.sendMessage(msg, chatId);
  }
}

enum Category { shoes, clothes, pants, shirts }
