import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp/features/dynamicLinks/firebase_dynamic_links.dart';
import 'package:notesapp/theme/colors.dart';
import 'package:notesapp/features/home/home.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import '../bookmarks/bookmarks.dart';
import '../search/search.dart';

class AppBottomNavigator extends ConsumerStatefulWidget {
  const AppBottomNavigator({super.key});

  @override
  ConsumerState<AppBottomNavigator> createState() => _AppBottomNavigatorState();
}

class _AppBottomNavigatorState extends ConsumerState<AppBottomNavigator>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;
  @override
  int selectedIndex = 0;
  final pages = [
    const HomePage(),
    const SearchPage(),
    const BookmarksPage(),
  ];
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.5,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    FirebaseDynamicLinkService.initDynamicLink(context, ref);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
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
              width: size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      //begin color
                      Colors.transparent,
                      //end color
                      Color.fromARGB(255, 0, 0, 0),
                    ]),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    size.width * 0.04, 0, size.width * 0.04, 0),
                color: Colors.transparent,
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
                          icon: (selectedIndex == 0)
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, size.height * 0.005),
                                  child: Icon(OctIcons.home_fill_24,
                                      size: size.height * 0.035))
                              : Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, size.height * 0.005),
                                  child: Icon(OctIcons.home_16,
                                      size: size.height * 0.035)),
                          label: 'Home',
                          tooltip: ''),
                      BottomNavigationBarItem(
                        icon: GestureDetector(
                          onDoubleTap: () =>
                              Routemaster.of(context).push('/mainsearch'),
                          onLongPress: () =>
                              Routemaster.of(context).push('/mainsearch'),
                          child: (selectedIndex == 1)
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 0, 0, size.height * 0.005),
                                  child: Icon(OctIcons.search_16,
                                      size: size.height * 0.035))
                              : Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0, 0, 0, size.height * 0.005),
                                    child: Icon(OctIcons.search_16,
                                        size: size.height * 0.035)),
                        ),
                        label: 'Search',
                        tooltip: '',
                      ),
                      BottomNavigationBarItem(
                        icon: (selectedIndex == 2)
                            ? Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, 0, size.height * 0.005),
                                child: Icon(OctIcons.bookmark_fill_24,
                                    size: size.height * 0.035))
                            : Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, 0, size.height * 0.005),
                                child: Icon(OctIcons.bookmark_16,
                                    size: size.height * 0.035)),
                        label: 'Bookmarks',
                        tooltip: '',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (index) => setState(() {
                          selectedIndex = index;
                        })),
              ),
            ),
          )
        ],
      ),
    );
    
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}


