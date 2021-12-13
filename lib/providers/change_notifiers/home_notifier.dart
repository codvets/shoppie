import 'package:flutter/cupertino.dart';

class HomeNotifier with ChangeNotifier {
  Category selectedCategory = Category.shoes;

  void changeCategory(Category category) {
    selectedCategory = category;

    notifyListeners();
  }
}

enum Category { shoes, clothes, pants, shirts }
