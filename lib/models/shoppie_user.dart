///[ShoppieUser] is a data model that we get and create on [Firestore] database
class ShoppieUser {
  final String email;
  final String name;
  String uid;
  String? image;

  /// [type] shall never be null
  final UserType? type;

  ShoppieUser({
    required this.type,
    required this.email,
    required this.name,
    this.image,
    required this.uid,
  }) : assert(type != null, "Type should never be null");

  factory ShoppieUser.fromJson(Map<String, dynamic> json,
          {required String uid}) =>
      ShoppieUser(
        uid: json["uid"] ?? uid,
        email: json['email'],
        name: json['name'],
        type: json['type'] == "buyer"
            ? UserType.buyer
            : json['type'] == null
                ? null
                : UserType.seller,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "type": type == UserType.buyer ? "buyer" : "seller",
        "image": image,
      };
}

enum UserType { seller, buyer }
