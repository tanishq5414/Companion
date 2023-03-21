import 'package:companion_rebuild/core/provider/courses_provider.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modal/courses_modal.dart';
import 'course_preview.dart';

List<Course> usercourses = [];
GridView courseBuilder(Size size, context, WidgetRef ref) {
  final user = ref.watch(userProvider)!;
  print(user);
  var userslist = user.cid;
  var allcourses = ref.read(coursesDataProvider);
  var usercourseslist = [];
  allcourses.when(
    data: (courses) {
      List<Course> allcourseslist = courses.map((e) => e).toList();
      for (var i = 0; i < userslist.length; i++) {
        for (var j = 0; j < allcourseslist.length; j++) {
          if (userslist[i] == allcourseslist[j].cid) {
            usercourseslist.add(allcourseslist[j]);
          }
        }
      }
    },
    error: ((error, stackTrace) => Text(error.toString())),
    loading: () => const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  );
  return GridView.builder(
      itemCount: usercourseslist.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (size.width / 190 / .8),
        mainAxisSpacing: 5,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CoursePreview(size, usercourseslist[index].cname,
            usercourseslist[index].cid.toString());
      });
}
