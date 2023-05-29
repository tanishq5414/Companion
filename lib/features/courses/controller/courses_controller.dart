import 'dart:convert';

import 'package:companion/apis/courses.api.dart';
import 'package:companion/core/core.dart';
import 'package:companion/features/hive/boxes.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:companion/features/hive/boxes.dart';

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

  Future<void> getCourses(
      BuildContext context, String token, bool internet) async {
    state = true;
    if (internet == true) {
      final res = await _coursesAPI.getCourses(token);
      res.fold((l) => showSnackBar(context, l.message), (courses) {
        _ref.read(coursesDataProvider.notifier).update((state) => courses);
        networkCache.put(
          'getCourses',
          courses.map((e) => jsonEncode(e.toJson())).toList(),
        );
      });
      
    }
    else{
      final courses = networkCache.get('getCourses');
      if (courses != null) {
        final List<String> courseListString = courses.cast<String>();
        List<CoursesModal> courseList = [];
        courseListString.forEach((noteString) {
          final Map<String, dynamic> noteMap = jsonDecode(noteString);
          courseList.add(CoursesModal.fromJson(noteMap));
        });
        _ref.read(coursesDataProvider.notifier).update((state) => courseList);
      }
    }
    state = false;
  }
}
