class AdvertismentModal {
  String? photoUrl;
  String? redirectLink;
  String? size;

  AdvertismentModal({this.photoUrl, this.redirectLink, this.size});

  AdvertismentModal.fromJson(Map<String, dynamic> json) {
    photoUrl = json['photoUrl'];
    redirectLink = json['redirectLink'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photoUrl'] = this.photoUrl;
    data['redirectLink'] = this.redirectLink;
    data['size'] = this.size;
    return data;
  }
}
