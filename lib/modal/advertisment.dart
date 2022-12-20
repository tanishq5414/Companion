import 'dart:convert';
// import 'dart:ffi';

List<Advertisment> advertFromJson(String str) => List<Advertisment>.from(json.decode(str).map((x) => Advertisment.fromJson(x)));

String advertToJson(List<Advertisment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Advertisment {
  String photoUrl;
  
  String redirectLink;
  
  String size;

    Advertisment({
        required this.photoUrl,
        required this.redirectLink,
        required this.size,

    });

    factory Advertisment.fromJson(Map<String, dynamic> json) => Advertisment(
        photoUrl: json["photoUrl"],
        redirectLink: json["redirectLink"],
        size: json["size"]
    );

  String? get imageUrl => null;

    Map<String, dynamic> toJson() => {
        "photoUrl": photoUrl,
        "redirectLink": redirectLink,
        "size": size,
    };
}
