class Message {
  String id;
  String userId;
  String message;
  DateTime savedAt;

  Message({
    this.id,
    this.userId,
    this.message,
    this.savedAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        userId: json["user_id"],
        message: json["message"],
        savedAt: DateTime.parse(json["savedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "message": message,
        "savedAt": savedAt.toIso8601String(),
      };
}
