///[ShoppieUser] is a data model that we get and create on [Firestore] database
class ShoppieUser {
  final String email;
  final String name;

  /// [type] shall never be null
  final UserType? type;

  ShoppieUser({required this.type, required this.email, required this.name})
      : assert(type != null, "Type should never be null");

  factory ShoppieUser.fromJson(Map<String, dynamic> json) => ShoppieUser(
        email: json['email'],
        name: json['name'],
        type: json['type'] == "buyer"
            ? UserType.buyer
            : json['type'] == null
                ? null
                : UserType.seller,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "type": type == UserType.buyer ? "buyer" : "seller",
      };
}

enum UserType { seller, buyer }
