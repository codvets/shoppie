import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/auth_notifier.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/routes.dart';
import 'package:shop_app/utils/utils.dart';

class GridContainer extends StatelessWidget {
  const GridContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.productDetails, arguments: product);
      },
      child: Padding(
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
                    product.discount == null
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(255, 121, 63, 1),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: null,
                              child: SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text(
                                    "${product.discount.toString()}%",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.grey),
                        onPressed: () {
                          Provider.of<HomeNotifier>(context, listen: false)
                              .favorizeProduct(
                            product,
                            Provider.of<AuthNotifier>(context, listen: false)
                                .currentUser
                                .uid,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: ScreenUtils.screenHeight(context) * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(product.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.discount != null
                          ? '\$${ScreenUtils.discountedPrice(product.price, product.discount!)}'
                          : "\$${product.price}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    if (product.discount != null) Text('\$${product.price}'),
                  ],
                ),
              ),
              Text(
                product.title,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
