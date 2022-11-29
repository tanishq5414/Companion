import 'package:flutter/material.dart';

import 'package:notesapp/theme/colors.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appWhiteColor,
      child: const Center(
        child: Text('Bookmarks'),
      ),
    );
  }
}