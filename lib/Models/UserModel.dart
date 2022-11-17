class User {
  String id;
  String username;
  String email;
  String type;

  User({
    this.id,
    this.username,
    this.email,
    this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "type": type,
      };
}
