import 'package:flutter/material.dart';

class TextHeading extends StatelessWidget {
  final heading;
  final size;
  const TextHeading({required this.heading, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(heading,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
