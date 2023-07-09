class CoursesModel {
  String? sId;
  int? cid;
  String? cname;
  List<String>? fileId;

  CoursesModel({this.sId, this.cid, this.cname, this.fileId});

  CoursesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cid = json['cid'];
    cname = json['cname'];
    var list = json['fileId'] ?? [];
    fileId = list.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['cid'] = this.cid;
    data['cname'] = this.cname;
    data['fileId'] = this.fileId;
    return data;
  }
}
