// import 'package:flutter/material.dart';
// import 'package:notesapp/provider/get_user_courses.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';
// import '../../domain/courses_modal.dart';
// import '../../domain/user_modal.dart';
// import '../../provider/user_provider.dart';
// import 'course_preview.dart';
// import '../../provider/get_courses.dart';

// GetCourses getCourses = GetCourses();

// FutureBuilder<List> courseBuilder(Size size, context) {
//   final UserCollection user = Provider.of<UserProvider>(context).getUser;
//   var userslist = user.cid;
//   print(userslist);
//   var allcourses = GetCourses.getCourses();

//   List<Course> usercourses = [];
//   allcourses.then((value) {
//     for (var i = 0; i < userslist.length; i++) {
//       for (var j = 0; j < value.length; j++) {
//         if (userslist[i] == value[j].cid) {
//           usercourses.add(value[j]);
//         }
//       }
//     }
//   });
//   // var futureusercourses = Future.value(usercourses);
//   // print(allcourses);
//   // print(usercourses[0].cid);
//   return FutureBuilder<List<Course>>(
//     future: usercourses as Future<List<Course>>,
//     builder: (context, snapshot) {
//       if (snapshot.hasData && user.cid.isNotEmpty) {
//         return GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: (size.width / 190 / .8),
//               mainAxisSpacing: 5,
//             ),
//             shrinkWrap: true,
//             itemCount: user.cid.length,
//             itemBuilder: (context, index) {
//               // print(snapshot.data![index].cid);
//               // print(snapshot.data![index].cid);
//               // return (userslist[index].cid == snapshot.data![index].cid)
//               //     ? CoursePreview(size, snapshot.data![index].cname,
//               //         snapshot.data![index].cid)
//               //     : SizedBox(
//               //         width: 0,
//               //         height: 0,
//               //       );
//               return CoursePreview(
//                   size, snapshot.data![index].cname, snapshot.data![index].cid);
//             });
//       } else if (snapshot.hasError) {
//         return Text("${snapshot.error}");
//       }
//       return const CircularProgressIndicator();
//     },
//   );
// }
