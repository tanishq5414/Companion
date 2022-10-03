import 'package:flutter/material.dart';
import 'package:notesapp/config/colors.dart';
import 'package:notesapp/pages/home/home.dart';

import '../bookmarks/bookmarks.dart';
import '../search/search.dart';

class AppBottomNavigator extends StatefulWidget {
  const AppBottomNavigator({super.key});

  @override
  State<AppBottomNavigator> createState() => _AppBottomNavigatorState();
}

class _AppBottomNavigatorState extends State<AppBottomNavigator> {
  int selectedIndex = 0;
  final pages = [
    const HomePage(),
    const SearchPage(),
    const BookmarksPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        //begin color
                        Colors.black,
                        //end color
                        Colors.transparent,
                      ]),),
              child: BottomNavigationBar(
                selectedItemColor: appAccentColor,
                unselectedItemColor: appWhiteColor,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                  elevation: 25,
                  backgroundColor: Colors.transparent,
                  items: const [
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
                  onTap: (index) => setState(() {
                        selectedIndex = index;
                      })),
            ),
          )
        ],
      ),
    );
  }
}
