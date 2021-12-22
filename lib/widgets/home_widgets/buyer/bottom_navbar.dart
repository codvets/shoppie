import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/routes.dart';
import 'package:shop_app/utils/utils.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            width: ScreenUtils.screenWidth(context),
            height: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomPaint(
                  size: Size(ScreenUtils.screenWidth(context), 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: StreamBuilder<List<Product>>(
                      stream: Provider.of<HomeNotifier>(context, listen: false)
                          .getCartProducts(
                              Provider.of<AuthNotifier>(context, listen: false)
                                  .currentUser
                                  .uid),
                      builder: (context, snapshot) {
                        log("snapshot: ${snapshot.data}");
                        int cartLength = 0;
                        if (snapshot.data != null) {
                          cartLength = snapshot.data!.length;
                          WidgetsBinding.instance!
                              .addPostFrameCallback((timeStamp) {
                            Provider.of<HomeNotifier>(context, listen: false)
                                .populateCart(snapshot.data!);
                          });
                        }

                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            FloatingActionButton(
                              backgroundColor:
                                  const Color.fromRGBO(255, 121, 63, 1),
                              child: const Icon(Icons.shopping_basket),
                              elevation: 0.1,
                              onPressed: () {
                                Navigator.of(context).pushNamed(Routes.cart,
                                    arguments: snapshot.data);
                              },
                            ),
                            if (cartLength > 0)
                              Positioned(
                                right: 5,
                                top: -5,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 14,
                                  child: Text(
                                    cartLength.toString(),
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  width: ScreenUtils.screenWidth(context),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: currentIndex == 0
                              ? const Color.fromRGBO(255, 121, 63, 1)
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setBottomBarIndex(0);
                        },
                        splashColor: Colors.white,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: currentIndex == 1
                                ? const Color.fromRGBO(255, 121, 63, 1)
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {}),
                      Container(
                        width: ScreenUtils.screenWidth(context) * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.chat,
                            color: currentIndex == 2
                                ? const Color.fromRGBO(255, 121, 63, 1)
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(2);
                          }),
                      IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: currentIndex == 3
                                ? const Color.fromRGBO(255, 121, 63, 1)
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            setBottomBarIndex(3);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
