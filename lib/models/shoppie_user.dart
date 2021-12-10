class ShoppieUser {
  final String email;
  final String name;
  final UserType type;

  ShoppieUser({required this.type, required this.email, required this.name});

  factory ShoppieUser.fromJson(Map<String, dynamic> json) => ShoppieUser(
        email: json['email'],
        name: json['name'],
        type: json['type'] == "buyer" ? UserType.buyer : UserType.seller,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "type": type == UserType.buyer ? "buyer" : "seller",
      };
}

enum UserType { seller, buyer }
