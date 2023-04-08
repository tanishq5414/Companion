import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/dynamicLinks/firebase_dynamic_links.dart';
import 'package:companion_rebuild/features/components/loader.dart';
import 'package:companion_rebuild/features/home/home.dart';
import 'package:companion_rebuild/features/premium/premiumpage.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
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
  @override
  int selectedIndex = 0;
  final pages = [
    const HomePage(),
    const SearchPage(),
    const BookmarksPage(),
    const PremiumPage(),
  ];

  @override
  void initState() {
    super.initState();
    //Future Delayed

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    // var isLoading = ref.read(authControllerProvider);
    final size = MediaQuery.of(context).size;
    FirebaseDynamicLinkService.initDynamicLink(context, ref);
    var items = [
      BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: (selectedIndex == 0)
              ? ZoomTapAnimation(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                    child:
                        Icon(OctIcons.home_fill_24, size: size.height * 0.035),
                  ),
                )
              : ZoomTapAnimation(
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                      child: Icon(OctIcons.home_16, size: size.height * 0.035)),
                ),
          label: 'Home',
          tooltip: ''),
      BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: GestureDetector(
          onDoubleTap: () => Routemaster.of(context).push('/mainsearch'),
          onLongPress: () => Routemaster.of(context).push('/mainsearch'),
          child: (selectedIndex == 1)
              ? ZoomTapAnimation(
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                      child:
                          Icon(OctIcons.search_16, size: size.height * 0.035)),
                )
              : ZoomTapAnimation(
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                      child:
                          Icon(OctIcons.search_16, size: size.height * 0.035)),
                ),
        ),
        label: 'Search',
        tooltip: '',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: (selectedIndex == 2)
            ? ZoomTapAnimation(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                    child: Icon(OctIcons.bookmark_fill_24,
                        size: size.height * 0.035)),
              )
            : ZoomTapAnimation(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                    child:
                        Icon(OctIcons.bookmark_16, size: size.height * 0.035)),
              ),
        label: 'Bookmarks',
        tooltip: '',
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: (selectedIndex == 3)
            ? ZoomTapAnimation(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                    child: Icon(OctIcons.heart_fill_24,
                        size: size.height * 0.035)),
              )
            : ZoomTapAnimation(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                    child: Icon(OctIcons.heart_16, size: size.height * 0.035)),
              ),
        label: 'Premium',
        tooltip: '',
      ),
    ];
    if (user == null) {
      items.removeLast();
    } else if (user.isPremiumUser) {
      setState(() {
        items.removeLast();
      });
    }
    return (user != null)
        ? Scaffold(
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
                          type: BottomNavigationBarType.fixed,
                          selectedItemColor: appWhiteColor,
                          unselectedItemColor: Colors.grey[600],
                          showSelectedLabels: true,
                          showUnselectedLabels: true,
                          selectedLabelStyle: const TextStyle(fontSize: 10),
                          unselectedLabelStyle: const TextStyle(fontSize: 10),
                          elevation: 40,
                          backgroundColor: Colors.transparent,
                          items: items,
                          currentIndex: selectedIndex,
                          onTap: (index) => setState(() {
                                selectedIndex = index;
                              })),
                    ),
                  ),
                )
              ],
            ),
          )
        : Loader();
  }
}
