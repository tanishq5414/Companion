// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrendingNotesModal {
  String notesname;
  String id;
  String course;
  String unit;
  int timesopened;
  int trendingnotestoday;
  int trendingnotesweekly;
  int trendingnotesmonthly;
  TrendingNotesModal({
    required this.notesname,
    required this.id,
    required this.course,
    required this.unit,
    required this.timesopened,
    required this.trendingnotestoday,
    required this.trendingnotesweekly,
    required this.trendingnotesmonthly,
  });

  TrendingNotesModal copyWith({
    String? notesname,
    String? id,
    String? course,
    String? unit,
    int? timesopened,
    int? trendingnotestoday,
    int? trendingnotesweekly,
    int? trendingnotesmonthly,
  }) {
    return TrendingNotesModal(
      notesname: notesname ?? this.notesname,
      id: id ?? this.id,
      course: course ?? this.course,
      unit: unit ?? this.unit,
      timesopened: timesopened ?? this.timesopened,
      trendingnotestoday: trendingnotestoday ?? this.trendingnotestoday,
      trendingnotesweekly: trendingnotesweekly ?? this.trendingnotesweekly,
      trendingnotesmonthly: trendingnotesmonthly ?? this.trendingnotesmonthly,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notesname': notesname,
      'id': id,
      'course': course,
      'unit': unit,
      'timesopened': timesopened,
    };
  }

  factory TrendingNotesModal.fromMap(Map<String, dynamic> map) {
    return TrendingNotesModal(
      notesname: map['notesname'] as String,
      id: map['id'] as String,
      course: map['course'] as String,
      unit: map['unit'] as String,
      timesopened: map['timesopened'] as int,
      trendingnotesmonthly: map['trendingnotesmonthly'] as int,
      trendingnotesweekly: map['trendingnotesweekly'] as int,
      trendingnotestoday: map['trendingnotestoday'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrendingNotesModal.fromJson(String source) =>
      TrendingNotesModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TrendingNotesModal(notesname: $notesname, id: $id, course: $course, unit: $unit, timesopened: $timesopened)';
  }

  @override
  bool operator ==(covariant TrendingNotesModal other) {
    if (identical(this, other)) return true;

    return other.notesname == notesname &&
        other.id == id &&
        other.course == course &&
        other.unit == unit &&
        other.timesopened == timesopened;
  }

  @override
  int get hashCode {
    return notesname.hashCode ^
        id.hashCode ^
        course.hashCode ^
        unit.hashCode ^
        timesopened.hashCode;
  }
}
