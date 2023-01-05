import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/home/home.dart';
import 'package:routemaster/routemaster.dart';

import '../bookmarks/bookmarks.dart';
import '../search/search.dart';

class AppBottomNavigator extends ConsumerStatefulWidget {
  const AppBottomNavigator({super.key});

  @override
  ConsumerState<AppBottomNavigator> createState() => _AppBottomNavigatorState();
}

class _AppBottomNavigatorState extends ConsumerState<AppBottomNavigator> {
  int selectedIndex = 0;
  final pages = [
    const HomePage(),
    const SearchPage(),
    const BookmarksPage(),
  ];
  @override
  // void initState() {
  // ignore: todo
  //   // TODO: implement initState
  //   super.initState();
  //   // final notesData = ref.watch(notesDataProvider);
  // }

  @override
  Widget build(BuildContext context) {
    // var isLoading = ref.read(authControllerProvider);
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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      //begin color
                      Colors.black,
                      //end color
                      Colors.transparent,
                    ]),
              ),
              child: BottomNavigationBar(
                  selectedItemColor: appWhiteColor,
                  unselectedItemColor: Colors.grey[600],
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedLabelStyle: const TextStyle(fontSize: 10),
                  unselectedLabelStyle: const TextStyle(fontSize: 10),
                  elevation: 35,
                  backgroundColor: Colors.transparent,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home, size: size.height * 0.04),
                        label: 'Home',
                        tooltip: ''),
                    BottomNavigationBarItem(

                      icon: 
                      GestureDetector(
                          onDoubleTap: () =>
                              Routemaster.of(context).push('/mainsearch'),
                          onLongPress: () =>
                              Routemaster.of(context).push('/mainsearch'),
                          child: Icon(Icons.search, size: size.height * 0.04)),
                      label: 'Search',
                      tooltip: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark, size: size.height * 0.04),
                      label: 'Bookmarks',
                      tooltip: '',
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
