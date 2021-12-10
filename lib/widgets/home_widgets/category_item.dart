import 'package:flutter/material.dart';
import 'package:shop_app/utils/screen_utils.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    Key? key,
    required this.itemName,
    required this.isSelected,
  }) : super(key: key);

  final String itemName;
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
        onPressed: null,
        child: SizedBox(
          width: ScreenUtils.screenWidth(context) * 0.2,
          child: Center(
            child: Text(
              itemName,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
