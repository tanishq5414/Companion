import 'package:companion/apis/courses.api.dart';
import 'package:companion/core/core.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coursesDataProvider = StateProvider<List<CoursesModal>?>((ref) => null);

final coursesControllerProvider =
    StateNotifierProvider<CoursesController, bool>((ref) {
  final courseAPI = ref.watch(coursesAPIProvider);
  return CoursesController(
    ref: ref,
    coursesAPI: courseAPI,
  );
});

class CoursesController extends StateNotifier<bool> {
  final CoursesAPI _coursesAPI;
  final Ref _ref;
  CoursesController({required CoursesAPI coursesAPI, required Ref ref})
      : _coursesAPI = coursesAPI,
        _ref = ref,
        super(false);

  Future<void> getCourses(BuildContext context) async {
    state = true;
    final res = await _coursesAPI.getCourses();
    res.fold((l) => showSnackBar(context, l.message), (courses) {
      _ref.read(coursesDataProvider.notifier).update((state) => courses);
    });
    state = false;
  }
}
