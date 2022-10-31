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
  final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          pages[selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.12,
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

                selectedItemColor: appWhiteColor,
                unselectedItemColor: Colors.grey[600],
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: TextStyle(fontSize: 10),
                unselectedLabelStyle: TextStyle(fontSize: 10),
                  elevation:35,
                  backgroundColor: Colors.transparent,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, size: size.height * 0.04),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search, size: size.height * 0.04),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark, size: size.height * 0.04),
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
