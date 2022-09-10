import 'dart:convert';

List<Course> courseFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
    Course({
        required this.name,
        required this.courseImageUrl,
    });

    String name;
    String courseImageUrl;

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        name: json["name"],
        courseImageUrl: json["courseImageUrl"],
    );

  String? get imageUrl => null;

    Map<String, dynamic> toJson() => {
        "name": name,
        "courseImageUrl": courseImageUrl,
    };
}
