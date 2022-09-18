import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import '../../domain/courses.dart';

Container CoursePreview(
  Size size,
  String courseName,
  String imageUrl,
) {
  return Container(
    margin: EdgeInsets.only(left: size.width*0.015,bottom: size.height*0.007,right: size.width*0.015),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        primary: Colors.white,
        fixedSize: Size(size.width * 0.34, size.height * 0.2),
        side: const BorderSide(color: Colors.grey, width: 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onPressed: () {},
      child: SizedBox(
        width: size.width / 2.1,
        height: size.height * 0.03,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.03,
            ),
            Flexible(
              child: Text(
                courseName,
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: size.width * 0.13,
            ),
          ],
        ),
      ),
    ),
  );
}
