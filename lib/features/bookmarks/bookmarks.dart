import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:notesapp/core/provider/notes_provider.dart';
import 'package:notesapp/core/provider/user_provider.dart';
import 'package:notesapp/features/auth/controller/auth_controller.dart';
import 'package:notesapp/features/bookmarks/components/bookmark_preview.dart';
import 'package:notesapp/features/components/notes_preview.dart';
import 'package:notesapp/features/settings/components/profiledisplay.dart';
import 'package:notesapp/modal/notes_modal.dart';

import 'package:notesapp/theme/colors.dart';
import 'package:routemaster/routemaster.dart';

import '../../modal/courses_modal.dart';
import '../components/custom_appbar.dart';

class BookmarksPage extends ConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider);
    final allnotes = ref.read(notesDataProvider);
    var allnoteslist;
    var userbookmarklist = user?.bid ?? [''];
    // print(userbookmarklist);
    List bookmarks = [];
    List getBookmarks() {
      allnotes.when(
          data: (notes) {
            allnoteslist = notes;
            // print(allnoteslist);
            for (var i = 0; i < allnoteslist.length; i++) {
              // print(userbookmarklist);
              if (userbookmarklist.contains(allnoteslist[i].id.toString())) {
                bookmarks.add(allnoteslist[i]);
              }
            }
            return bookmarks;
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator());
      return bookmarks;
    }

    var bookmarklist = getBookmarks();
    // print(bookmarklist);
    // print(bookmarks);
    // var bookmarks = getBookmarks();
    // print(bookmarks);
    // print(allnoteslist);
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: appBackgroundColor,
            elevation: 0,
            title: const Text('Your bookmarks',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),),
            toolbarHeight: 120,
            leading: Padding(
              padding: EdgeInsets.only(left: size.width * 0.04,),
              child: ProfileAvatar(image: user!.photoUrl, firstlettername: user.name[0], rad: 22, width: 1),
            ),
            leadingWidth: 55,
          ),
        ],
        body: Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.width * 0.02,
              right: size.width * 0.03),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  wdlink: bookmarks[index].wdlink)),
        ),
      )),
    );
  }
}
