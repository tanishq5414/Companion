import 'package:flutter/material.dart';

class TextHeading extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final heading;
  // ignore: prefer_typing_uninitialized_variables
  final size;
  const TextHeading({super.key, required this.heading, this.size});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(heading,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
