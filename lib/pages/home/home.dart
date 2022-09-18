// ignore_for_file: prefer_const_constructors, unused_element

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notesapp/pages/bookmarks/bookmarks.dart';
import 'package:notesapp/pages/search/search.dart';
import 'package:notesapp/pages/components/coursePreview.dart';
import 'package:notesapp/domain/courses.dart';

import '../components/notesPreview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  static Future<List<Course>> getCourses() async {
    const coursesDataJson = 'https://tanishq5414.github.io/apiNotesApp/courses1.json';
    final response = await http.get(Uri.parse(coursesDataJson));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load courses from API');
    }
  }

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
      primary: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const CircleBorder(),
      // side: BorderSide(color: Colors.grey, width: 1),
    );

    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(
            top: size.height * 0.06,
            left: size.width * 0.05,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Good ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(greeting(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Spacer(),
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
                ),
                const SizedBox(height: 20),
                FutureBuilder<List<Course>>(
                  future: getCourses(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: size.height * 0.07,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(right: size.width * 0.05),
                              child: CoursePreview(
                                  size,
                                  snapshot.data![index].name,
                                  snapshot.data![index].courseImageUrl),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Trending Today',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Recently Viewed',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Your Bookmarks',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
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
        );
  }

  

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
