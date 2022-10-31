// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../config/colors.dart';
class CustomHeading extends StatelessWidget {
  final title;

  const CustomHeading({
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
