import 'package:companion/features/courses/controller/courses_controller.dart';
import 'package:companion/features/hive/boxes.dart';
import 'package:companion/features/home/views/home_view.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/notes/views/bookmarks_view.dart';
import 'package:companion/features/search/views/search_main.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/theme/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NavView extends ConsumerStatefulWidget {
  final User firebaseUser;
  static route({
    required User token,
  }) =>
      MaterialPageRoute(
          builder: (context) => NavView(
                firebaseUser: token,
              ));
  const NavView({super.key, required this.firebaseUser, String? imageUrl});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavViewState();
}

class _NavViewState extends ConsumerState<NavView> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getUserData() async {
        await ref
            .read(userControllerProvider.notifier)
            .getUserData(context: context, uid: widget.firebaseUser.uid);
      }

      widget.firebaseUser.getIdToken(false).then((value) {
        ref.read(notesControllerProvider.notifier).getNotes(context);
        ref.read(coursesControllerProvider.notifier).getCourses(context);
        ref.read(notesControllerProvider.notifier).getTrendingNotes(context);
        ref.read(notesControllerProvider.notifier).addDataForTrendingNotes();
      });

      getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var user = ref.watch(userDataProvider);
    final pages = [
      const HomeView(),
      const SearchView(),
      const BookmarksView(),
      const HomeView(),
    ];

    var items = [
      BottomNavigationBarItem(
          backgroundColor: Colors.transparent,
          icon: (selectedIndex == 0)
              ? ZoomTapAnimation(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                    child:
                        Icon(OctIcons.home_fill_24, size: size.height * 0.04),
                  ),
                )
              : ZoomTapAnimation(
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                      child: Icon(OctIcons.home_16, size: size.height * 0.04)),
                ),
          label: 'Home',
          tooltip: ''),
      BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: GestureDetector(
          onDoubleTap: () => {},
          onLongPress: () => {},
          child: (selectedIndex == 1)
              ? ZoomTapAnimation(
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                      child:
                          Icon(OctIcons.search_16, size: size.height * 0.04)),
                )
              : ZoomTapAnimation(
                  child: Container(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                      child:
                          Icon(OctIcons.search_16, size: size.height * 0.04)),
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
                        size: size.height * 0.04)),
              )
            : ZoomTapAnimation(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, size.height * 0.009),
                    child:
                        Icon(OctIcons.bookmark_16, size: size.height * 0.04)),
              ),
        label: 'Your Bookmarks',
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
    } else if (user.isPremiumUser!) {
      setState(() {
        items.removeLast();
      });
    }
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              pages[selectedIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          //begin color
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(1.0),
                        ]),
                  ),
                  height: size.height * 0.16,
                  width: size.width,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(size.width * 0.07,
                        size.width * 0.03, size.width * 0.07, 0),
                    // color: Colors.transparent,
                    child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        selectedItemColor: Pallete.whiteColor,
                        unselectedItemColor: Pallete.darkGreyColor,
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
        ),
      ),
    );
  }
}
