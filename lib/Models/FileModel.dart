class FilesModel {
  String userid;
  String filename;
  String path;
  DateTime savedAt;
  String id;

  FilesModel({this.userid, this.filename, this.savedAt, this.path, this.id});

  factory FilesModel.fromJson(Map<String, dynamic> json) => FilesModel(
        userid: json["user_id"],
        filename: json["filename"],
        path: json["path"],
        savedAt: DateTime.parse(json["savedAt"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userid,
        "filename": filename,
        "path": path,
        "savedAt": savedAt.toIso8601String(),
      };
}
