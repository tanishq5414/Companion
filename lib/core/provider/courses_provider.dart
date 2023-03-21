import 'package:companion_rebuild/core/keys/courses_api.dart';
import 'package:companion_rebuild/modal/courses_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final coursesDataProvider = FutureProvider<List<Course>>((ref) async {
  return ref.watch(coursesProvider).getCourses();
});
