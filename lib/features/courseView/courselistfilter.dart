import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/courses_provider.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/features/auth/repository/firebase_auth_methods.dart';
import 'package:notesapp/features/components/course_builder.dart';

import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/custom_appbar.dart';
import 'package:routemaster/routemaster.dart';
import '../../modal/courses_modal.dart';

List<String> CoursesSearchList = [];

class CourseListFilterPage extends ConsumerStatefulWidget {
  CourseListFilterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseListFilterPageState();
}

class _CourseListFilterPageState extends ConsumerState<CourseListFilterPage> {
  late var usercourseslist;
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
    // print(courses);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Course List Filter',
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Stack(
        children: [
          courses.when(
            data: (courses) {
              List<Course> courseList = courses.map((e) => e).toList();
              for (int i = 0; i < courseList.length; i++) {
                if (CoursesSearchList.contains(
                    courseList[i].cname.toString())) {
                } else {
                  CoursesSearchList.add(courseList[i].cname.toString());
                }
              }
              return ListView.builder(
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  bool _isSelected =
                      usercourseslist.contains(courseList[index].cid);
                  return CheckboxListTile(
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    title: Text(courseList[index].cname,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    value: _isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        print(value);
                        if (value == true &&
                            usercourseslist.contains(courseList[index].cid) ==
                                false &&
                            usercourseslist.length < 6) {
                          usercourseslist.add(courseList[index].cid);
                        } else {
                          usercourseslist.remove(courseList[index].cid);
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: appBackgroundColor,
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
                          style: TextStyle(color: appAccentColor, fontSize: 15),
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
            print(CoursesSearchList.length);
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
