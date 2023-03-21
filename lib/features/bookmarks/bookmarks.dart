// ignore_for_file: non_constant_identifier_names, unnecessary_new, unused_local_variable

import 'package:companion_rebuild/core/provider/notes_provider.dart';
import 'package:companion_rebuild/features/auth/controller/auth_controller.dart';
import 'package:companion_rebuild/features/components/notes_preview.dart';
import 'package:companion_rebuild/features/settings/components/profiledisplay.dart';
import 'package:companion_rebuild/modal/notes_modal.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


List<String> BookmarkSearchList = [];

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider);
    final allnotes = ref.read(notesDataProvider);
    List<Notes> allnoteslist;
    var userbookmarklist = user?.bid ?? [''];
    List bookmarks = [];

    // print(userbookmarklist);
    List getBookmarks() {
      allnotes.when(
          data: (notes) {
            allnoteslist = notes;
            // print(allnoteslist);
            for (var i = 0; i < userbookmarklist.length; i++) {
              for (var j = 0; j < allnoteslist.length; j++) {
                if (userbookmarklist[i].toString() ==
                    allnoteslist[j].id.toString()) {
                  bookmarks.add(allnoteslist[j]);
                }
              }
            }
            bookmarks= new List.from(bookmarks.reversed);
            return bookmarks;
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator());
      return bookmarks;
    }


    var bookmarkslist = getBookmarks();

    for (var i = 0; i < bookmarks.length; i++) {
      BookmarkSearchList.add(bookmarks[i].name);
      BookmarkSearchList.add(bookmarks[i].course);
      BookmarkSearchList.add(bookmarks[i].unit);
    }
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.03),
      color: appBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: appBackgroundColor,
              elevation: 0,
              title: const Text(
                'Your Bookmarks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              toolbarHeight: 120,
              leading: ZoomTapAnimation(
                onTap: () {
                  Routemaster.of(context).push('/editprofile');
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.04,
                  ),
                  child: ProfileAvatar(
                      image: user!.photoUrl,
                      firstlettername: user.name[0],
                      rad: 20,
                      width: 2),
                ),
              ),
              leadingWidth: 55,
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   height: size.height * 0.05,
                //   width: size.width * 0.9,
                //   margin: EdgeInsets.symmetric(horizontal: size.width * 0.035),
                //   decoration: BoxDecoration(
                //     color: appBackgroundColor,
                //     borderRadius: BorderRadius.circular(2),
                //   ),
                //   child: InkWell(
                //     onTap: () {
                //       showSearch(
                //         context: context,
                //         delegate: CustomBookmarkSearchDelegate(),
                //       );
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: const [
                //         Text('Search in bookmarks',
                //             style: TextStyle(
                //                 color: appGreyColor,
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.bold)),
                //         Spacer(),
                //         Icon(Icons.search, color: appGreyColor),
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: bookmarks.length,
                      itemBuilder: (context, index) => NotesPreview(
                          id: bookmarks[index].id,
                          name: bookmarks[index].name,
                          year: bookmarks[index].year,
                          branch: bookmarks[index].branch,
                          course: bookmarks[index].course,
                          semester: bookmarks[index].semester,
                          version: bookmarks[index].version,
                          unit: bookmarks[index].unit,
                          wdlink: bookmarks[index].wdlink,
                          pressable: true,)),
                ),
              ],
            ),
          ),
              )),
      ),
    );
  }
}

class CustomBookmarkSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var scourse in BookmarkSearchList) {
      if (scourse.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(scourse);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(
              result,
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (String scourse in BookmarkSearchList) {
      if (scourse.contains(query.toLowerCase())) {
        matchQuery.add(scourse);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(
              result,
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
  }
}
