import 'dart:convert';

List<Notes> notesFromJson(String str) =>
    List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

String notesToJson(List<Notes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notes {
  Notes({
    required this.id,
    required this.name,
    required this.year,
    required this.branch,
    required this.course,
    required this.semester,
    required this.version,
    required this.unit,
    required this.wdlink,
  });
  String id;
  String name;
  String year;
  String branch;
  String course;
  String semester;
  String version;
  String unit;
  String wdlink;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        id: json["g_id"],
        name: json["name"],
        year: json["year"].toString(),
        branch: json["branch"],
        course: json["course"],
        semester: json["semester"].toString(),
        version: json["version"].toString(),
        unit: json["unit"].toString(),
        wdlink: json["wdlink"],
      );

  String? get imageUrl => null;

  Map<String, dynamic> toJson() => {
        "g_id": id, 
        "name": name,
        "year": year.toString(),
        "branch": branch,
        "course": course,
        "semester": semester.toString(),
        "version": version.toString(),
        "unit": unit.toString(),
        "wdlink": wdlink,
      };
}
