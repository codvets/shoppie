import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/screen_utils.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    Key? key,
    required this.category,
    required this.isSelected,
  }) : super(key: key);

  final Category category;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              isSelected ? Color.fromRGBO(255, 121, 63, 1) : Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {
          Provider.of<HomeNotifier>(context, listen: false)
              .changeCategory(category);
        },
        child: SizedBox(
          width: ScreenUtils.screenWidth(context) * 0.2,
          child: Center(
            child: Text(
              category.toString().split('.')[1].toUpperCase(),
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
