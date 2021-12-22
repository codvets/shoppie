import 'package:flutter/material.dart';
import 'package:shop_app/common/radial_gradient_mask.dart';
import 'package:shop_app/screens/buyer/cart.dart';
import 'package:shop_app/utils/utils.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.screenHeight(context) * 0.12,
      width: ScreenUtils.screenWidth(context) * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0, left: 10),
            child: Center(
              child: RadiantGradientMask(
                child: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Liberty Mall, Arbab Road",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Peshawar, Pakistan",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff9B9BCA),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              tooltip: 'Next Page',
              onPressed: (null),
            ),
          ),
        ],
      ),
    );
  }
}
