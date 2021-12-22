import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/utils.dart';

class OrderDetailsCard extends StatelessWidget {
  OrderDetailsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (context, provider, _) {
      print("I AM BUILDING");
      return Container(
        height: ScreenUtils.screenHeight(context) * 0.5,
        width: ScreenUtils.screenWidth(context) * 1,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                child: Text(
                  'Order Info',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xff272750),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 15.0,
                  right: 15.0,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    child: Text(
                      'Subtotal',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff2C2C54),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 10.0, right: 130.0)),
                Padding(
                    child: Text(
                      "\$${getTotalPrice(provider.cartProducts)}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff2C2C54),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 110.0, right: 10.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Padding(
                    child: Text(
                      'Shipping Cost',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff2C2C54),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 10.0, right: 100.0)),
                Padding(
                    child: Text(
                      "+\$10.00",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff2C2C54),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 110.0, right: 10.0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    child: Text(
                      'Total',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff2C2C54),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 10.0, right: 160.0)),
                Padding(
                    child: Text(
                      "\$${getTotalPrice(provider.cartProducts) + 10}",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff2C2C54),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 110.0, right: 10.0)),
              ],
            ),
            InkResponse(
              onTap: () {
                provider.buyProductsFromCart();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 30.0, left: 20.0, right: 10.0),
                child: Container(
                  height: ScreenUtils.screenHeight(context) * 0.12,
                  width: ScreenUtils.screenWidth(context) * 0.9,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffFF793F),
                        Color(0xffFFA984),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  double getTotalPrice(List<Product> products) {
    double totalCost = 0.0;

    products.forEach((element) {
      totalCost += (element.price * element.quantity!);
    });
    return totalCost;
  }
}
