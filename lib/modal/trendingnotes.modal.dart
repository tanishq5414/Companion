class CoursesModal {
  String? notesname;
  String? id;
  String? course;
  String? unit;
  int? timesopened;
  int? trendingnotestoday;
  int? trendingnotesweekly;
  int? trendingnotesmonthly;

  CoursesModal(
      {this.notesname,
      this.id,
      this.course,
      this.unit,
      this.timesopened,
      this.trendingnotestoday,
      this.trendingnotesweekly,
      this.trendingnotesmonthly});

  CoursesModal.fromJson(Map<String, dynamic> json) {
    notesname = json['notesname'];
    id = json['id'];
    course = json['course'];
    unit = json['unit'];
    timesopened = json['timesopened'];
    trendingnotestoday = json['trendingnotestoday'];
    trendingnotesweekly = json['trendingnotesweekly'];
    trendingnotesmonthly = json['trendingnotesmonthly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notesname'] = this.notesname;
    data['id'] = this.id;
    data['course'] = this.course;
    data['unit'] = this.unit;
    data['timesopened'] = this.timesopened;
    data['trendingnotestoday'] = this.trendingnotestoday;
    data['trendingnotesweekly'] = this.trendingnotesweekly;
    data['trendingnotesmonthly'] = this.trendingnotesmonthly;
    return data;
  }
}
