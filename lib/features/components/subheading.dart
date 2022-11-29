import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final subheading;
  // ignore: prefer_typing_uninitialized_variables
  final size;
  const SubHeading({super.key, required this.subheading, this.size});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(subheading,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
    );
  }
}
