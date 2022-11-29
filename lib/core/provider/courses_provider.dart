import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/services/courses_api.dart';
import 'package:notesapp/modal/courses_modal.dart';

final coursesDataProvider = FutureProvider<List<Course>>((ref) async {
  return ref.watch(coursesProvider).getCourses();
});
