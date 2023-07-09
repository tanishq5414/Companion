class AdvertismentModel {
  String? photoUrl;
  String? size;
  String? title;
  String? subititle;
  String? description;
  String? redirectUrl;
  bool? display;

  AdvertismentModel(
      {this.photoUrl,
      this.size,
      this.title,
      this.subititle,
      this.description,
      this.redirectUrl,
      this.display});

  AdvertismentModel.fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'];
    size = json['size'];
    title = json['title'];
    subititle = json['subititle'];
    description = json['description'];
    redirectUrl = json['redirectUrl'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['size'] = this.size;
    data['title'] = this.title;
    data['subititle'] = this.subititle;
    data['description'] = this.description;
    data['redirectUrl'] = this.redirectUrl;
    data['display'] = this.display;
    return data;
  }
}
