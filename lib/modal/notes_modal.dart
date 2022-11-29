import 'dart:convert';

List<Notes> notesFromJson(String str) =>
    List<Notes>.from(json.decode(str).map((x) => Notes.fromJson(x)));

String notesToJson(List<Notes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notes {
  Notes({
    required this.name,
    required this.year,
    required this.branch,
    required this.course,
    required this.semester,
    required this.version,
    required this.unit,
    required this.wdlink,
});
  String name;
  String year;
  String branch;
  String course;
  String semester;
  String version;
  String unit;
  String wdlink;

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        name: json["name"],
        year: json["year"],
        branch: json["branch"],
        course: json["course"],
        semester: json["semester"],
        version: json["version"],
        unit: json["unit"],
        wdlink: json["wdlink"],
      );

  String? get imageUrl => null;

  Map<String, dynamic> toJson() => {
        "name": name,
        "year": year,
        "branch": branch,
        "course": course,
        "semester": semester,
        "version": version,
        "unit": unit,
        "wdlink": wdlink,
      };
}
