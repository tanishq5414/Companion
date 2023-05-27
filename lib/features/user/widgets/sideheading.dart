// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';



class SideHeading extends StatelessWidget {
  var title;

  SideHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: size.width * 0.03,top: size.width * 0.03),
        child: Text(title,
            style: const TextStyle(
              color: Pallete.whiteColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            )),
      ),
    );
  }
}
