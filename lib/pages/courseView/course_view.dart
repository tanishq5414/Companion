import 'package:flutter/material.dart';

import '../components/custom_appbar.dart';

class CourseViewPage extends StatelessWidget {
  const CourseViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Course View',
      ),
      body: const Center(
        child: Text(
          'CourseViewPage',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}