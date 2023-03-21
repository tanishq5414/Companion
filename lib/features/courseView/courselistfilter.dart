// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, prefer_typing_uninitialized_variables

import 'package:companion_rebuild/core/provider/courses_provider.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/custom_appbar.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../modal/courses_modal.dart';

List<String> CoursesSearchList = [];

class CourseListFilterPage extends ConsumerStatefulWidget {
  const CourseListFilterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseListFilterPageState();
}

class _CourseListFilterPageState extends ConsumerState<CourseListFilterPage> {
  late List usercourseslist;
  @override
  void initState() {
    var user = ref.read(userProvider)!;
    usercourseslist = user.cid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final courses = ref.read(coursesDataProvider);
    List<Course> selectedCourses = [];
    List<Course> unselectedCourses = [];
    List<Course> courseListFinal = [];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Course List Filter',
      ),
      body: Stack(
        children: [
          courses.when(
            data: (courses) {
              List<Course> courseList = courses.map((e) => e).toList();
              courseList.sort((a, b) => a.cname.compareTo(b.cname));
              for (var course in courseList) {
                if (usercourseslist.contains(course.cid)) {
                  selectedCourses.add(course);
                } else {
                  unselectedCourses.add(course);
                }
              }
              courseListFinal = selectedCourses + unselectedCourses;
              return ListView.builder(
                itemCount: courseListFinal.length,
                itemBuilder: (context, index) {
                  bool isSelected =
                      usercourseslist.contains(courseListFinal[index].cid);
                  return CheckboxListTile(
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    title: Text(courseListFinal[index].cname,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true &&
                            usercourseslist.contains(courseListFinal[index].cid) ==
                                false &&
                            usercourseslist.length < 6) {
                          usercourseslist.add(courseListFinal[index].cid);
                        } else {
                          usercourseslist.remove(courseListFinal[index].cid);
                        }
                      });
                    },
                  );
                },
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height * 0.1,
              color: appBackgroundColor,
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Container(
                  width: size.width,
                  height: size.height * 0.1,
                  color: appBackgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${usercourseslist.length.toString()}/6 selected',
                          style: const TextStyle(
                              color: appWhiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      const SizedBox(
                        width: 10,
                      ),
                      ZoomTapAnimation(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            splashFactory: NoSplash.splashFactory,
                            backgroundColor: appBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .updateUserCourses(
                                    context, user.id, usercourseslist);
                            Routemaster.of(context).pop();
                          },
                          child: const Text(
                            'Save',
                            style:
                                TextStyle(color: appAccentColor, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var scourse in CoursesSearchList) {
      if (scourse.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(scourse);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(
              result,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (String scourse in CoursesSearchList) {
      if (scourse.contains(query.toLowerCase())) {
        matchQuery.add(scourse);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(
              result,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }
}
