import 'package:flutter/material.dart';
import 'package:notesapp/provider/get_user_courses.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../domain/courses_modal.dart';
import '../../domain/user_modal.dart';
import '../../provider/user_provider.dart';
import 'course_preview.dart';
import '../../provider/get_courses.dart';

List<Course> usercourses = [];
GridView courseBuilder(Size size, context) {
  final UserCollection user = Provider.of<UserProvider>(context).getUser;
  var userslist = user.cid;
  // print(userslist);
  // print(userslist);
  var allcourses = GetCourses.getCourses();

  allcourses.then((value) {
    if (usercourses.isNotEmpty) {
      usercourses = [];
    }
    for (var i = 0; i < userslist.length; i++) {
      for (var j = 0; j < value.length; j++) {
        if (userslist[i] == value[j].cid) {
          usercourses.add(value[j]);
          // print(usercourses);
        }
      }
    }
  });
  print(usercourses);
  return GridView.builder(
      itemCount: usercourses.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (size.width / 190 / .8),
        mainAxisSpacing: 5,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // print(usercourses);
        return CoursePreview(
            size, usercourses[index].cname, usercourses[index].cid);
      });
}
