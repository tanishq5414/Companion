import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modal/courses_modal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetCourses{
  final coursesDataJson =
        'https://tanishq5414.github.io/apiNotesApp/coursesnumber.json';
  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse(coursesDataJson));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses from API');
    }
  }
}
final coursesProvider = Provider<GetCourses>((ref) => GetCourses());
