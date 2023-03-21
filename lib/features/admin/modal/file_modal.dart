import 'dart:convert';

List<File> notesFromJson(String str) =>
    List<File>.from(json.decode(str).map((x) => File.fromJson(x)));

String notesToJson(List<File> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class File {
  File({
    required this.fileId,
    required this.webContentLink,
  });
  String fileId;
  String webContentLink;

  factory File.fromJson(Map<String, dynamic> json) => File(
        fileId: json["fileId"],
        webContentLink: json["webContentLink"],
      );

  String? get imageUrl => null;

  Map<String, dynamic> toJson() => {
        "fileId": fileId,
        "webContentLink": webContentLink,
      };
}
