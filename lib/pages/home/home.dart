// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/bookmarks/bookmarks.dart';
import 'package:notesapp/pages/components/heading.dart';
import 'package:notesapp/pages/search/search.dart';
import 'package:notesapp/pages/components/course_preview.dart';
import 'package:notesapp/domain/courses.dart';

import '../components/course_builder.dart';
import '../components/notes_preview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Search',
      style: optionStyle,
    ),
    Text(
      'Index 2: Bookmarks',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        HomePage();
        break;
      case 1:
        Search();
        break;
      case 2:
        BookmarkPage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ButtonStyle leadingStyle = ElevatedButton.styleFrom(
      minimumSize: Size(size.height * 0.05, size.height * 0.05),
      primary: appWhiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const CircleBorder(),
      // side: BorderSide(color: Colors.grey, width: 1),
    );

    return Container(
      color: appWhiteColor,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: appWhiteColor,
              elevation: 0,
              title: Row(
                children: [
                  Text('Good ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(greeting(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
              actions: [
                TextButton(
                  style: leadingStyle,
                  child: const Icon(Icons.notification_important_outlined,
                      color: Colors.black),
                  onPressed: () {},
                ),
                TextButton(
                  style: leadingStyle,
                  child: Icon(Icons.settings, color: Colors.black),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
              ],
            ),
            backgroundColor: appWhiteColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CourseBuilder(size),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: TextHeading(
                          heading: 'Trending today',
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: TextHeading(heading: 'Recently added'),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.02),
                        child: TextHeading(heading: 'Your bookmarks'),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            NotesPreview(size),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: Colors.black.withOpacity(0.8),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.16),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                elevation: 0,
                backgroundColor: Colors.transparent,
                unselectedItemColor: Colors.white70,
                selectedLabelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                selectedItemColor: Colors.white,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "lib/assets/pictures/home.png",
                      height: size.height * 0.05,
                      color: Colors.white70,
                    ),
                    activeIcon: Image.asset(
                      "lib/assets/pictures/home.png",
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "lib/assets/pictures/search.png",
                      color: Colors.white70,
                      height: size.height * 0.05,
                    ),
                    activeIcon: Image.asset(
                      "lib/assets/pictures/search.png",
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "lib/assets/pictures/bookmark.png",
                      height: size.height * 0.05,
                      color: Colors.white70,
                    ),
                    activeIcon: Image.asset(
                      "lib/assets/pictures/bookmark.png",
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                    label: 'Bookmarks',
                  ),
                ],
                onTap: _onItemTapped,
              ),
            )
            //
            ),
      ),
    );
  }


  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    }
    if (hour < 17) {
      return 'afternoon';
    }
    return 'evening';
  }
}
