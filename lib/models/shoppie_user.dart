class ShoppieUser {
  final String email;
  final String name;

  ShoppieUser({required this.email, required this.name});

  factory ShoppieUser.fromJson(Map<String, dynamic> json) =>
      ShoppieUser(email: json['email'], name: json['name']);

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
