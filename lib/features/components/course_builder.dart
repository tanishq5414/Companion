import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/courses_provider.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import '../../modal/courses_modal.dart';
import '../../modal/user_modal.dart';
import 'course_preview.dart';

List<Course> usercourses = [];
GridView courseBuilder(Size size, context, WidgetRef ref) {
  final user = ref.watch(userProvider)!;
  var userslist = user.cid;
  var allcourses = ref.read(coursesDataProvider);
  var usercourseslist = [];
/* timelineData.when(
        data: (timeline) {
          List<Timeline> timelineList = timeline.map((e) => e).toList();
          for (var i = 0; i < timelineList.length; i++) {
            if (timelineList[i].rid == tid) {
              timelineDataList.add(timelineList[i]);
            }
          }
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));*/

  allcourses.when(
      data: (courses) {
        List<Course> allcourseslist = courses.map((e) => e).toList();
        for (var i = 0; i < allcourseslist.length; i++) {
          if (userslist.contains(allcourseslist[i].cid)) {
            usercourseslist.add(allcourseslist[i]);
          }
        }
      },
      error: ((error, stackTrace) => Text(error.toString())),
      loading: () => Center(
            child: CircularProgressIndicator(),
          ));
  // var user = ref.watch(userProvider)?.id;
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
        // print  (usercourses);
        return CoursePreview(
            size, usercourseslist[index].cname, usercourseslist[index].cid);
      });
}
