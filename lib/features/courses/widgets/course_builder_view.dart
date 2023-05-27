import 'package:companion/features/courses/controller/courses_controller.dart';
import 'package:companion/features/courses/widgets/course_preview.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<CoursesModal> usercourses = [];
GridView courseBuilder(Size size, context, WidgetRef ref) {
  final user = ref.watch(userDataProvider)!;
  List<String> userslist = user.cid!;
  var allcourseslist = ref.watch(coursesDataProvider)!;
  var usercourseslist = [];
  for (var i = 0; i < userslist.length; i++) {
    for (var j = 0; j < allcourseslist.length; j++) {
      if (userslist[i] == allcourseslist[j].cid.toString()) {
        usercourseslist.add(allcourseslist[j]);
      }
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
