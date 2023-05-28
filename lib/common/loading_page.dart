import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Pallete.whiteColor,
        strokeWidth: 6.0,
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: const Scaffold(
          body: Loader(),
        ),
      ),
    );
  }
}

