import 'package:flutter/material.dart';
import '../models/courses.dart';

ElevatedButton CoursePreview(
  Size size,
  String courseName,
  String imageUrl,
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.zero,
      padding: EdgeInsets.zero,
      onPrimary: Colors.grey,
      primary: Colors.white,
      side: BorderSide(color: Colors.grey, width: 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    onPressed: () {},
    child: SizedBox(
      width: size.width * 0.4,
      height: size.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 0),
            width: size.width * 0.13,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(8),
                  bottomStart: Radius.circular(8)),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              courseName,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 11.5, color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  );
}
