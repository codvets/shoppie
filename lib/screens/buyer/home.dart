import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/screen_utils.dart';
import 'package:shop_app/widgets/home_widgets/category_item.dart';
import 'package:shop_app/widgets/home_widgets/search_bar.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    // color: Colors.red,

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.menu, size: 25, color: Colors.grey),
                            onPressed: () {
                              Provider.of<HomeNotifier>(context, listen: false)
                                  .getProducts();
                            },
                          ),
                          IconButton(
                              onPressed: () {
                                Provider.of<AuthNotifier>(context,
                                        listen: false)
                                    .logout(context);
                              },
                              icon: Icon(Icons.shop,
                                  size: 25, color: Colors.grey)),
                        ],
                      ),
                    ),
                    // color: Colors.red,
                    height: ScreenUtils.screenHeight(context) * 0.08,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: ScreenUtils.screenWidth(context) * 0.7,
                            child: SearchBar(),
                          ),
                          const Icon(
                            Icons.vertical_split_rounded,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: ScreenUtils.screenHeight(context) * 0.07,
                    width: ScreenUtils.screenWidth(context) * 0.9,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      // color: Colors.green,
                      height: ScreenUtils.screenHeight(context) * 0.035,
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Category",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "See All",
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.blue,
                    height: ScreenUtils.screenHeight(context) * 0.1,
                    child:
                        Consumer<HomeNotifier>(builder: (context, provider, _) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final cat = Category.values[index];
                          return CategoryItem(
                              category: cat,
                              isSelected: cat == provider.selectedCategory);
                        },
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      // color: Colors.green,
                      height: ScreenUtils.screenHeight(context) * 0.035,
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Trending",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "See All",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.blue,
                    height: ScreenUtils.screenHeight(context) * 0.5,
                    child: FutureBuilder<List<Product>>(
                      future: Provider.of<HomeNotifier>(context, listen: false)
                          .getProducts(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Center(
                                child: Text('No internet connection'));

                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator());

                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            {
                              if (snapshot.hasData) {
                                final data = snapshot.data!;

                                final shoes = data
                                    .where((product) =>
                                        product.category == "Clothes")
                                    .toList();
                                return Consumer<HomeNotifier>(
                                  builder: (context, provider, _) {
                                    switch (provider.selectedCategory) {
                                      case Category.shoes:
                                        return CategoryBuilder(items: shoes);
                                      case Category.clothes:
                                        return CategoryBuilder(items: shoes);

                                      case Category.pants:
                                        return CategoryBuilder(items: shoes);

                                      case Category.shirts:
                                        return CategoryBuilder(items: shoes);
                                    }
                                  },
                                );
                              }
                              return Center(
                                  child: Text("No products yet found"));
                            }
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: ScreenUtils.screenHeight(context) * 0.11,
                child: const BottomNavBar(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<String> shoes = ["shoe1", "shoe2", "shoe3"];
  List<String> clothes = [
    "clothes1",
    "clothes2",
  ];
  List<String> pants = [
    "pants1",
    "spant2",
    "pants3",
    "pants3",
    "pants3",
    "pants3"
  ];
  List<String> shirts = [];
}

class CategoryBuilder extends StatelessWidget {
  CategoryBuilder({
    Key? key,
    required this.items,
  }) : super(key: key);

  List<Product> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        final item = items[index];
        return Text(item.title);
      },
      itemCount: items.length,
    );
  }
}

class GridContainer extends StatelessWidget {
  const GridContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        // height: ScreenUtils.screenHeight(context) * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 121, 63, 1),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: null,
                      child: const SizedBox(
                        width: 30,
                        child: Center(
                          child: Text(
                            "12%",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.favorite_border, color: Colors.grey),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: ScreenUtils.screenHeight(context) * 0.11,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://5.imimg.com/data5/VD/XE/UY/SELLER-61106641/red-black-shoes-jpeg-500x500.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '\$125.0',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('\$125.0'),
                ],
              ),
            ),
            const Text(
              'Nike Air Shoes',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

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
                  child: FloatingActionButton(
                      backgroundColor: const Color.fromRGBO(255, 121, 63, 1),
                      child: const Icon(Icons.shopping_basket),
                      elevation: 0.1,
                      onPressed: () {}),
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
                          onPressed: () {
                            setBottomBarIndex(1);
                          }),
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
