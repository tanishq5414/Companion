import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';

import 'search.dart';

class MainSearchPage extends StatelessWidget {
  const MainSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: appBackgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appGreyColor,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: TextField(
                  autofocus: true,
                  cursorColor: appAccentColor,
                  cursorHeight: 15,
                  // textAlignVertical: TextAlignVertical.top,
                  showCursor: true,
                  cursorRadius: Radius.circular(2),
                  cursorWidth: 2,
                  decoration: InputDecoration(
                    hintText: "Search notes, courses, etc.",
                    hintTextDirection: TextDirection.ltr,
                    contentPadding: EdgeInsets.only(left: size.width * 0.035),
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(color: appBlackColor, fontSize: 15, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Search Results'),
    );
  }
}
