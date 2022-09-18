import 'package:flutter/material.dart';

import '../domain/courses.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCourses{
  static Future<List<Course>> getCourses() async {
    const coursesDataJson =
        'https://tanishq5414.github.io/apiNotesApp/courses1.json';
    const NotesDataJson =
        'https://tanishq5414.github.io/apiNotesApp/notes1.json';
    final response = await http.get(Uri.parse(coursesDataJson));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses from API');
    }
  }

}
