class NotesModal {
  String? sId;
  String? gId;
  String? name;
  int? year;
  String? branch;
  String? course;
  int? semester;
  int? version;
  int? unit;
  String? reslink;
  String? createdAt;
  String? fileId;
  String? author;
  int? iV;

  NotesModal(
      {this.sId,
      this.gId,
      this.name,
      this.year,
      this.branch,
      this.course,
      this.semester,
      this.version,
      this.unit,
      this.reslink,
      this.createdAt,
      this.fileId,
      this.author,
      this.iV});

  NotesModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gId = json['g_id'];
    name = json['name'];
    year = json['year'];
    branch = json['branch'];
    course = json['course'];
    semester = json['semester'];
    version = json['version'];
    unit = json['unit'];
    reslink = json['reslink'];
    createdAt = json['createdAt'];
    fileId = json['fileId'];
    author = json['author'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['g_id'] = this.gId;
    data['name'] = this.name;
    data['year'] = this.year;
    data['branch'] = this.branch;
    data['course'] = this.course;
    data['semester'] = this.semester;
    data['version'] = this.version;
    data['unit'] = this.unit;
    data['reslink'] = this.reslink;
    data['createdAt'] = this.createdAt;
    data['fileId'] = this.fileId;
    data['author'] = this.author;
    data['__v'] = this.iV;
    return data;
  }
}
