import 'package:flutter/material.dart';

class CourseViewPage extends StatelessWidget {
  const CourseViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CourseViewPage'),
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