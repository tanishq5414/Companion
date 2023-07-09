// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:companion/features/courses/views/course_view.dart';
import 'package:companion/model/courses.model.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CoursePreview extends StatefulWidget {
  CoursePreview(this.size, this.course, {super.key});
  late Size size;
  late CoursesModel course;
  @override
  State<CoursePreview> createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return BasicSliverAppBar(course: widget.course);
        }));
      },
      child: Container(
        width: widget.size.width * 0.45,
        height: widget.size.height * 0.9,
        margin: EdgeInsets.only(right: widget.size.width * 0.02),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Pallete.greyColor),
        child: Row(
          children: [
            SizedBox(
              width: widget.size.width * 0.05,
            ),
            SizedBox(
              width: widget.size.width * 0.3,
              child: Text(
                widget.course.cname!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
