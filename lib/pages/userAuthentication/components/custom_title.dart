import 'package:flutter/material.dart';

import '../../../config/colors.dart';
class CustomHeading extends StatelessWidget {
  late var title = 'Enter a title';

  CustomHeading({
    Key? key,
    required this.title,
  }) : super(key: key,);
  


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: appWhiteColor,
        ),
      ),
    );
  }
}
