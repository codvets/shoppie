import 'package:flutter/material.dart';
import 'package:shop_app/common/radial_gradient_mask.dart';
import 'package:shop_app/screens/buyer/cart.dart';
import 'package:shop_app/utils/utils.dart';

class PaymentDetailsCard extends StatelessWidget {
  const PaymentDetailsCard({
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0, left: 20.0),
            child: Center(
              child: RadiantGradientMask(
                child: Icon(
                  Icons.credit_card,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 40.0, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Visa Classic",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "****-8921",
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
            padding: EdgeInsets.only(left: 130, top: 10.0),
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
