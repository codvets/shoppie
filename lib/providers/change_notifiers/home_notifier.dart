import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/repo/network.dart';

class HomeNotifier with ChangeNotifier {
  Category selectedCategory = Category.shoes;

  Network _network = Network();

  void changeCategory(Category category) {
    selectedCategory = category;

    notifyListeners();
  }

  List<Product> cartProducts = List.empty(growable: true);

  List<Product> products = List.empty(growable: true);

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
    cartProducts.addAll(cartItems);
    notifyListeners();
  }
}

enum Category { shoes, clothes, pants, shirts }
