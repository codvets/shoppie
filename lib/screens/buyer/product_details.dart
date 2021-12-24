import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/routes.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 60)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.blueGrey,
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 50,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(colors: [
                                        Color(0xffC18D47),
                                        Color(0xffC17347),
                                        Color(0xffF34C1B),
                                      ])),
                                  child: const Center(
                                    child: Text(
                                      "-30%",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://www.nicepng.com/png/detail/20-207880_picture-id-big-kids-basketball-for-pinterest-nike.png")),
                                  borderRadius: BorderRadius.circular(5),
                                  //color: Colors.orangeAccent,
                                ),
                              ),
                            ],
                          ),

                          //second column
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20)),
                              const Text(
                                "\$180.04",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              const Text(
                                "Nike Orange",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.blueGrey),
                              )
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.only(
                            left: 30,
                          )),
                          Column(
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color(0xffC18D47),
                                        Color(0xffC17347),
                                        Color(0xffF34C1B),
                                      ])),
                                  child: Center(
                                    child: const Text(
                                      "Buy",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(product.image))),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //last container
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.discount == null
                                      ? "\$${product.price}"
                                      : "\$${product.price - (product.price * product.discount! / 100)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        homeProvider(context).favorizeProduct(
                                            product,
                                            authProvider(context)
                                                .currentUser
                                                .uid);
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orangeAccent,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.amber),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(Routes.chat);
                                      },
                                      child: Text("Chat with Seller"),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Nike Air Shoes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Choose Size",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orangeAccent,
                                    ),
                                    child: Center(
                                      child: const Text("data",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 2.0),
                                        color: Colors.white),
                                    child: Center(
                                      child: const Text("data",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 2.0),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "data",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.19,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.black, width: 2.0),
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: Text("data"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Price\n\$${product.price}.00",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeProvider(context).addToCart(
                          product, authProvider(context).currentUser.uid);
                    },
                    child: Container(
                      height: 65,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(35)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffC18D47),
                            Color(0xffC17347),
                            Color(0xffF34C1B),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  HomeNotifier homeProvider(context, {bool listen = false}) =>
      Provider.of<HomeNotifier>(context, listen: listen);
  AuthNotifier authProvider(context, {bool listen = false}) =>
      Provider.of<AuthNotifier>(context, listen: listen);
}
