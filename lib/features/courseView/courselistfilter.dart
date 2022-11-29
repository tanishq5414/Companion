import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/core/provider/courses_provider.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/features/auth/repository/firebase_auth_methods.dart';
import 'package:notesapp/features/components/course_builder.dart';

import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/components/custom_appbar.dart';
import '../../modal/courses_modal.dart';

class CourseListFilterPage extends ConsumerStatefulWidget {
  const CourseListFilterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseListFilterPageState();
}

class _CourseListFilterPageState extends ConsumerState<CourseListFilterPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final courses = ref.read(coursesDataProvider);
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
              return ListView.builder(
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: appWhiteColor,
                    checkColor: appWhiteColor,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    title: Text(
                      courseList[index].cname,
                      style: const TextStyle(color: appWhiteColor),
                    ),
                    value: user.cid.contains(courseList[index].cid),
                    // value: true,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true &&
                            user.cid.contains(courseList[index].cid) == false &&
                            user.cid.length < 6) {
                          user.cid.add(courseList[index].cid);
                        } else {
                          user.cid.remove(courseList[index].cid);
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
                      Text('${user.cid.length.toString()}/6 selected',
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (route) => false);
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
