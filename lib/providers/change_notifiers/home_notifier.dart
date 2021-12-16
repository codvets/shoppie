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

  Future<List<Product>> getProducts() async {
    return await _network.getProducts();
  }
}

enum Category { shoes, clothes, pants, shirts }
