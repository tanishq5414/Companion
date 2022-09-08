// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final user = FirebaseAuth.instance.currentUser;
  int selected = 2;
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
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        Navigator.pushNamed(context, '/bookmarks');
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
            left: size.width * 0.1,
            right: size.width * 0.1,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      Text(FirebaseAuth.instance.currentUser!.displayName.toString(),
                          style: TextStyle(
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
                SizedBox(
                  height: size.height * 0.03,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        bookBuilder(size),
                        Spacer(),
                        bookBuilder(size),
                      ],
                    ),
                    Row(
                      children: [
                        bookBuilder(size),
                        Spacer(),
                        bookBuilder(size),
                      ],
                    ),
                    Row(
                      children: [
                        bookBuilder(size),
                        Spacer(),
                        bookBuilder(size),
                      ],
                    ),
                    Row(
                      children: [
                        bookBuilder(size),
                        Spacer(),
                        bookBuilder(size),
                      ],
                    ),
                    Row(
                      children: [
                        bookBuilder(size),
                        Spacer(),
                        bookBuilder(size),
                      ],
                    ),
                    Row(
                      children: [
                        bookBuilder(size),
                        Spacer(),
                        bookBuilder(size),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black.withOpacity(0.8),
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.16),
          child: BottomNavigationBar(
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
            currentIndex: selected,
            onTap: _onItemTapped,
          ),
        )
        //
        );
  }

  ElevatedButton courseBuilder(Size size) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        onPrimary: Colors.grey,
        primary: Colors.white,
        side: BorderSide(color: Colors.grey, width: 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onPressed: () {},
      child: SizedBox(
        width: size.width * 0.4,
        height: size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0),
              width: size.width * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(8),
                    bottomStart: Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage('lib/assets/pictures/black.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                'DBMS',
                overflow: TextOverflow.fade,
                style: const TextStyle(fontSize: 11.5, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container trendingBuilder(Size size) {
    return Container(
      width: size.width * 0.34,
      child: Column(
        children: [
          TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              onPrimary: Colors.grey,
              primary: Colors.white,
            ),
            onPressed: () {},
            child: SizedBox(
              width: size.width * 0.34,
              height: size.width * 0.34,
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.34,
                    height: size.width * 0.34,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/pictures/black.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Unit 5',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text('v4.0',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ],
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Data Mining',
                style: TextStyle(fontSize: 11, color: Colors.black),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container recentBuilder(Size size) {
    return Container(
      width: size.width * 0.34,
      child: Column(
        children: [
          TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              onPrimary: Colors.grey,
              primary: Colors.white,
            ),
            onPressed: () {},
            child: SizedBox(
              width: size.width * 0.34,
              height: size.width * 0.34,
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.34,
                    height: size.width * 0.34,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/pictures/black.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Unit 1',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text('v1.0',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ],
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Web Technologies',
                style: TextStyle(fontSize: 11, color: Colors.black),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container bookBuilder(Size size) {
    return Container(
      width: size.width * 0.34,
      child: Column(
        children: [
          TextButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              onPrimary: Colors.grey,
              primary: Colors.white,
            ),
            onPressed: () {},
            child: SizedBox(
              width: size.width * 0.34,
              height: size.width * 0.34,
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.34,
                    height: size.width * 0.34,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/pictures/black.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Unit 3',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text('v3.0',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ],
          ),
          SizedBox(
            height: size.height * 0.007,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'DBMS',
                style: TextStyle(fontSize: 11, color: Colors.black),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ],
      ),
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
