import 'package:companion/common/common.dart';
import 'package:companion/common/sectionchip.dart';
import 'package:companion/core/core.dart';
import 'package:companion/features/courses/controller/courses_controller.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/modal/courses.modal.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CourseFilterView extends ConsumerStatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CourseFilterView());
  }

  const CourseFilterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourseListFilterPageState();
}

class _CourseListFilterPageState extends ConsumerState<CourseFilterView> {
  TextEditingController editingController = TextEditingController();

  late List<String> usercourseslist;
  late List<CoursesModal> courseListFinal;
  late List<CoursesModal> courseList;
  @override
  void initState() {
    super.initState();
    var user = ref.read(userDataProvider)!;
    usercourseslist = List.from(user.cid!);
    List<CoursesModal> selectedCourses = [];
    List<CoursesModal> unselectedCourses = [];
    var courses = ref.read(coursesDataProvider);
    courseList = courses!;
    courseList.sort((a, b) => a.cname!.compareTo(b.cname!));
    for (var course in courseList) {
      if (usercourseslist.contains(course.cid.toString())) {
        selectedCourses.add(course);
      } else {
        unselectedCourses.add(course);
      }
    }
    courseListFinal = selectedCourses + unselectedCourses;
  }

  @override
  void dispose() {
    super.dispose();
    usercourseslist = [];
  }

  void filterSearchResults(String query) {
    setState(() {
      courseListFinal = courseList
          .where(
              (item) => item.cname!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userDataProvider)!;
    var size = MediaQuery.of(context).size;
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Select your courses',
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.1),
                child: Container(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            onChanged: (value) {
                              filterSearchResults(value);
                            },
                            controller: editingController,
                            decoration: const InputDecoration(
                              prefixIconColor: Colors.white,
                              iconColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              prefixIcon: Icon(Icons.search),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: courseListFinal.length,
                          itemBuilder: (context, index) {
                            bool isSelected = usercourseslist
                                .contains(courseListFinal[index].cid.toString());
                            return CheckboxListTile(
                              activeColor: Colors.white,
                              side: const BorderSide(color: Colors.white, width: 2),
                              checkColor: Colors.black,
                              title: Text(courseListFinal[index].cname ?? 'No Name',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                              value: isSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true &&
                                      usercourseslist.contains(
                                              courseListFinal[index]
                                                  .cid
                                                  .toString()) ==
                                          false) {
                                    usercourseslist
                                        .add(courseListFinal[index].cid.toString());
                                  } else {
                                    usercourseslist.remove(
                                        courseListFinal[index].cid.toString());
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  height: size.height * 0.1,
                  color: Pallete.backgroundColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.05, right: size.width * 0.07),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.1,
                      color: Pallete.backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${usercourseslist.length.toString()}/6 selected',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          ZoomTapAnimation(
                              child: SectionChip(
                            backgroundColor: Pallete.whiteColor,
                            textColor: Pallete.blackColor,
                            label: 'Save',
                            onTap: () {
                              if (usercourseslist.length > 6) {
                                showSnackBar(
                                    context, 'You can select only 6 courses');
                                return;
                              }
                              ref
                                  .read(userControllerProvider.notifier)
                                  .updateUserCourses(
                                    context,
                                    user.uid!,
                                    usercourseslist,
                                  );
                              Navigator.pop(context);
                            },
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
