import 'dart:convert';
// import 'dart:ffi';

List<Course> courseFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
    Course({
        required this.cname,
        required this.cid,
        required this.gid,
        // required this.gid,
    });

    String cname;
    int cid;
    List gid;
    // Array gid;

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        cname: json["cname"],
        cid: json["cid"],
        gid: json["gid"],
        // gid: json["gid"],
    );

  String? get imageUrl => null;

    Map<String, dynamic> toJson() => {
        "cname": cname,
        "cid": cid,
        "gid": gid,
    };
}
