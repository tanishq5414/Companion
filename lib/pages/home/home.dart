// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';

import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/bookmarks/bookmarks.dart';
import 'package:notesapp/pages/components/heading.dart';
import 'package:notesapp/pages/components/notes_builder.dart';
import 'package:notesapp/pages/search/search.dart';

import '../components/course_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
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
      backgroundColor: appWhiteColor,
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    courseBuilder(size),
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
                              notesBuilder(size),
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
                              notesBuilder(size),
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
                              notesBuilder(size),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black.withOpacity(0.9),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.1, right: size.width * 0.1),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      selectedIconTheme: IconThemeData(color: Colors.white),
                      selectedLabelStyle: TextStyle(color: Colors.white),
                      unselectedIconTheme: IconThemeData(color: Colors.grey),
                      unselectedLabelStyle: TextStyle(color: Colors.white),
                      elevation: 0,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          label: 'Search',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.bookmark),
                          label: 'Bookmarks',
                        ),
                      ],
                      currentIndex: selectedIndex,
                      selectedItemColor: Colors.black,
                      onTap: _onItemTapped,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
