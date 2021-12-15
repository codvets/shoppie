class Product {
  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.discount,
    required this.sellerId,
    required this.id,
  });

  String image;
  String title;
  String description;
  double price;
  String category;
  int? discount;
  String sellerId;
  String id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        image: json["image"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        discount: json["discount"],
        sellerId: json["sellerId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "description": description,
        "price": price,
        "category": category,
        "discount": discount,
        "sellerId": sellerId,
        "id": id,
      };
}
