class TrendingModal {
  String? fileId;
  int? accessToday;
  int? accessWeekly;

  TrendingModal({this.fileId, this.accessToday, this.accessWeekly});

  TrendingModal.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    accessToday = json['accessToday'];
    accessWeekly = json['accessWeekly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['accessToday'] = this.accessToday;
    data['accessWeekly'] = this.accessWeekly;
    return data;
  }
}
