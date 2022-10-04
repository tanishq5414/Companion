// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class CustomSubtitle extends StatelessWidget {
  var text = 'Enter a title';

  CustomSubtitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          color: appWhiteColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
