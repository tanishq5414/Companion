import 'package:flutter/material.dart';

import '../../domain/courses_modal.dart';
import 'course_preview.dart';
import '../../provider/get_courses.dart';

GetCourses getCourses = GetCourses();

FutureBuilder<List<Course>> courseBuilder(Size size) {
  return FutureBuilder<List<Course>>(
    future: GetCourses.getCourses(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Container(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (size.width / 190 / .8),
              mainAxisSpacing: 5,
            ),
            
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return CoursePreview(size, snapshot.data![index].name,
                  snapshot.data![index].courseImageUrl);
            },
          ),
        );
      } else if (snapshot.hasError) {
        return const Text('Error');
      }
      return const CircularProgressIndicator();
    },
  );
}
