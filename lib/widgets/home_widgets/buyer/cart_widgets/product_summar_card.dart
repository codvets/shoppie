import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/change_notifiers/home_notifier.dart';
import 'package:shop_app/utils/utils.dart';

class ProductSummaryCard extends StatefulWidget {
  ProductSummaryCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  Product product;

  @override
  State<ProductSummaryCard> createState() => _ProductSummaryCardState();
}

class _ProductSummaryCardState extends State<ProductSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: <Widget>[
          Container(
            height: ScreenUtils.screenHeight(context) * 0.2,
            width: ScreenUtils.screenWidth(context) * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 10,
                  ),
                  child: SizedBox(
                    height: ScreenUtils.screenHeight(context) * 0.2,
                    width: ScreenUtils.screenWidth(context) * 0.4,
                    child: Image(
                      image: NetworkImage(widget.product.image),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "\$${widget.product.price}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          if (widget.product.discount != null)
                            Text(
                              " \$${ScreenUtils.discountedPrice(widget.product.price, widget.product.discount!)}",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      Text(
                        widget.product.title,
                        style: TextStyle(
                            color: Color(0xffBCBCDC),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (widget.product.discount != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 0.0),
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xffFF793F),
                                          Color(0xffFFA984),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${widget.product.discount.toString()}%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsets.only(right: 0.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove_circle_outline_sharp,
                                    color: Color(0xff9B9BCA),
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    print(widget.product.quantity);
                                    if (widget.product.quantity != null) {
                                      if (widget.product.quantity! > 1) {
                                        int quantity = widget.product.quantity!;
                                        quantity--;

                                        widget.product.quantity = quantity;
                                        print(widget.product.quantity);
                                        setState(() {});
                                      }
                                    }
                                  },
                                ),
                              ),
                              Text(
                                widget.product.quantity.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline_sharp,
                                      color: Color(0xff9B9BCA),
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      if (widget.product.quantity != null) {
                                        int quantity = widget.product.quantity!;
                                        quantity++;
                                        widget.product.quantity = quantity;
                                        print(widget.product.quantity);

                                        Provider.of<HomeNotifier>(context,
                                                listen: false)
                                            .changeQuantity(
                                                quantity, widget.product.id);
                                        setState(() {});
                                      }
                                    }),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 50,
              width: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffFF793F),
                    Color(0xffFFA984),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                //DecorationImage
              ), //BoxDecoration
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 25,
                  ),
                  tooltip: 'Location',
                  onPressed: () {
                    Provider.of<HomeNotifier>(context, listen: false)
                        .deleteProductFromCart(widget.product.id);
                  },
                ),
              ),
            ),
          ),

          // const BinItem(),
        ],
      ),
    );
  }
}
