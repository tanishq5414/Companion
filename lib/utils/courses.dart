class Course {
  final String name;
  final String courseImageUrl;

  const Course({
    required this.name,
    required this.courseImageUrl,
  });
  static Course fromJson(json) => Course(
        name: json['name'],
        courseImageUrl: json['courseImageUrl'],
      );
}
