import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modal/courses_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCourses {
  final coursesDataJson = 'http://10.0.2.2:3000/api/v1/getJsonFiles';
  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse(coursesDataJson));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Course> courses = [];
      for (var item in jsonResponse['filesjson']) {
        courses.add(Course.fromJson(item));
      }
      return courses;
    } else {
      throw Exception('Failed to load courses from API');
    }
  }
}

final coursesProvider = Provider<GetCourses>((ref) => GetCourses());
