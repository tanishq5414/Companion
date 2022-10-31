// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';

import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/bookmarks/bookmarks.dart';
import 'package:notesapp/pages/components/heading.dart';
import 'package:notesapp/pages/components/notes_builder.dart';
import 'package:notesapp/pages/search/search.dart';
import 'package:notesapp/provider/get_courses.dart';
import 'package:notesapp/provider/get_user_courses.dart';
import 'package:provider/provider.dart';

import '../../domain/courses_modal.dart';
import '../../provider/user_provider.dart';
import '../components/course_builder.dart';
import '../components/subheading.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<UserProvider>(context, listen: false).refreshUser();
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ButtonStyle leadingStyle = ElevatedButton.styleFrom(
      minimumSize: Size(size.height * 0.05, size.height * 0.05),
      backgroundColor: appBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const CircleBorder(),
      // side: BorderSide(color: Colors.grey, width: 1),
    );

    return Container(
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appBackgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: appBackgroundColor,
                elevation: 0,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Good ',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Text(greeting(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
                actions: [
                  TextButton(
                    style: leadingStyle,
                    child: const Icon(Icons.notification_important_outlined,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                  TextButton(
                    style: leadingStyle,
                    child: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),
            ],
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.04,
                                  right: size.width * 0.04),
                              child: SubHeading(
                                subheading: 'Your courses',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.04,
                                  right: size.width * 0.04),
                              child: InkWell(
                                child: Icon(
                                  Icons.filter_list,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/courselistfilter');
                                },
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      courseBuilder(size, context),
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
              ],
            ),
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
