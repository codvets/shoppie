import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/utils.dart';
import 'package:shop_app/widgets/home_widgets/buyer/bottom_navbar.dart';
import 'package:shop_app/widgets/home_widgets/buyer/category_builder.dart';
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
                            onPressed: () {},
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
                    child:
                        Consumer<HomeNotifier>(builder: (context, provider, _) {
                      return FutureBuilder<List<Product>>(
                        future: provider.getProducts(provider.selectedCategory),
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
                                  if (data.isEmpty)
                                    return Center(
                                        child: Text("No products yet found"));
                                  return Consumer<HomeNotifier>(
                                    builder: (context, provider, _) {
                                      return CategoryBuilder(items: data);
                                    },
                                  );
                                }
                                return Center(
                                    child: Text("No products yet found"));
                              }
                          }
                          return SizedBox();
                        },
                      );
                    }),
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
}
