

import 'package:flutter/material.dart';

import '../components/custom_appbar.dart';

class AboutCompanion extends StatelessWidget {
  const AboutCompanion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About Companion'
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text('Companion is an innovative student-based notes app designed specifically for college students. The app is designed to be a reliable companion for students throughout their academic journey, from taking notes in class to preparing for exams. \n\n With Companion, students can easily take and organize their notes on their smartphones or tablets. The app allows students to categorize their notes based on subjects and topics, making it easy to access specific information when needed. \n\n Companion also has a powerful search feature, allowing students to quickly find specific notes or information within their notes. \n\n Additionally, students can add tags to their notes, making it easier to filter and organize their notes based on specific keywords.'),
      )
    );
  }
}