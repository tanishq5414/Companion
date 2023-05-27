
class CoursesModal {
  List<String>? fileId;
  String? sId;
  int? cid;
  String? cname;
  List<String>? gid;

  CoursesModal({this.fileId, this.sId, this.cid, this.cname, this.gid});

  CoursesModal.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'].cast<String>();
    sId = json['_id'];
    cid = json['cid'];
    cname = json['cname'];
    gid = json['gid'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId ?? [];
    data['_id'] = this.sId;
    data['cid'] = this.cid;
    data['cname'] = this.cname;
    data['gid'] = this.gid;
    return data;
  }
}
