import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}

class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Pallete.backgroundColor,
        child: SafeArea(child: Scaffold(body: Center(child: Text(error)))));
  }
}
