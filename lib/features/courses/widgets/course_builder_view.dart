import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/courses/controller/courses_controller.dart';
import 'package:companion/features/courses/widgets/course_preview.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<CoursesModal> usercourses = [];
GridView courseBuilder(Size size, context, WidgetRef ref) {
  final user = ref.watch(userDataProvider)??nullUser;
  List<String> userslist = user.cid!;
  var allcourseslist = ref.watch(coursesDataProvider)??[];
  var usercourseslist = [];
  Set<String> usersSet = Set<String>.from(userslist);

  for (var course in allcourseslist) {
    if (usersSet.contains(course.cid.toString())) {
      usercourseslist.add(course);
    }
  }
  return GridView.builder(
      itemCount: usercourseslist.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (size.width / 190 / .7),
        mainAxisSpacing: 7,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // return CoursePreview(size, 'Advanced Flutter', '1');
        return CoursePreview(size, usercourseslist[index]);
      });
}
