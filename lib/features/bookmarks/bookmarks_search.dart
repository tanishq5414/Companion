// ignore_for_file: unused_import, prefer_is_empty

import 'package:companion_rebuild/core/provider/notes_provider.dart';
import 'package:companion_rebuild/modal/notes_modal.dart';
import 'package:companion_rebuild/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../auth/controller/auth_controller.dart';

class BookmarksSearchPage extends ConsumerStatefulWidget {
  const BookmarksSearchPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<BookmarksSearchPage> {
  List<Notes> foundedNotes = [];
  List<Notes> _notes = [];

  List<Notes> getBookmarks(AsyncValue<List<Notes>> allnotes, user) {
    List<Notes> bookmarks = [];
    List<Notes> allnoteslist;
    var userbookmarklist = user?.bid ?? [''];
    allnotes.when(
        data: (notes) {
          allnoteslist = notes;
          for (var i = 0; i < userbookmarklist.length; i++) {
            for (var j = 0; j < allnoteslist.length; j++) {
              if (userbookmarklist[i].toString() ==
                  allnoteslist[j].id.toString()) {
                bookmarks.add(allnoteslist[j]);
              }
            }
          }
          bookmarks = List.from(bookmarks.reversed);
          return bookmarks;
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const CircularProgressIndicator());
    return bookmarks;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: todo
      // TODO: implement initState
      final allnotes = ref.read(notesDataProvider);
      var user = ref.watch(userProvider);
      _notes = getBookmarks(allnotes, user);
      setState(() {
        foundedNotes = _notes;
      });
    });
  }

  onSearch(String search) {
    setState(() {
      final allnotes = ref.read(notesDataProvider);
      var user = ref.watch(userProvider);
      _notes = getBookmarks(allnotes, user);
      foundedNotes = _notes
          .where((notes) =>
              notes.name.toLowerCase().contains(search) |
              notes.course.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final allnotes = ref.read(notesDataProvider);
    var user = ref.watch(userProvider);
    List<Notes> allnoteslist;
    var userbookmarklist = user?.bid ?? [''];
    List bookmarks = [];
    List getBookmarks() {
      allnotes.when(
          data: (notes) {
            allnoteslist = notes;
            for (var i = 0; i < userbookmarklist.length; i++) {
              for (var j = 0; j < allnoteslist.length; j++) {
                if (userbookmarklist[i].toString() ==
                    allnoteslist[j].id.toString()) {
                  bookmarks.add(allnoteslist[j]);
                }
              }
            }
            bookmarks = List.from(bookmarks.reversed);
            return bookmarks;
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator());
      return bookmarks;
    }

    var bookmarkslist = getBookmarks();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Scaffold(
          appBar: AppBar(
            leading: ZoomTapAnimation(
                child: IconButton(
                    icon: const Icon(
                      OctIcons.arrow_left_16,
                      size: 15,
                    ),
                    onPressed: () => Routemaster.of(context).history.back())),
            elevation: 0,
            backgroundColor: appBackgroundColor,
            title: Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(2)),
              child: TextField(
                autofocus: true,
                style: const TextStyle(color: appWhiteColor),
                onChanged: (value) => onSearch(value.toLowerCase()),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: const Icon(
                      OctIcons.search_16,
                      size: 20,
                      color: appWhiteColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none),
                    hintStyle:
                        const TextStyle(fontSize: 14, color: appWhiteColor),
                    hintText: "Search in your library"),
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: size.width * 0.05),
            color: appBackgroundColor,
            child: foundedNotes.length > 0
                ? ListView.builder(
                    itemCount: foundedNotes.length > 15 ? 15 : foundedNotes.length,
                    itemBuilder: (context, index) {
                      return notesComponent(notes: foundedNotes[index]);
                    })
                : const Center(
                    child: Text(
                    "No notes found",
                    style: TextStyle(
                      color: appWhiteColor,
                    ),
                  )),
          ),
        ),
      ),
    );
  }

  notesComponent({required Notes notes}) {
    return InkWell(
      onTap: () => Routemaster.of(context).push('/pdfview', queryParameters: {
        'id': notes.id.toString(),
        'name': notes.name,
        'year': notes.year,
        'branch': notes.branch,
        'course': notes.course,
        'semester': notes.semester,
        'version': notes.version,
        'unit': notes.unit,
        'wdlink': notes.wdlink,
      }),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            ZoomTapAnimation(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notes.name,
                    style: const TextStyle(color: appWhiteColor, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    notes.course,
                    style: const TextStyle(color: appGreyColor, fontSize: 14),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              '${notes.unit} Unit',
              style: const TextStyle(color: appGreyColor, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
