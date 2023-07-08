// ignore_for_file: unused_import, prefer_is_empty

import 'package:companion/core/providers/dummy_user_provider.dart';
import 'package:companion/features/hive/boxes.dart';
import 'package:companion/features/notes/controller/notes_controller.dart';
import 'package:companion/features/notes/views/notes_menu.dart';
import 'package:companion/features/notes/views/notes_pdf_view.dart';
import 'package:companion/features/user/controller/user_controller.dart';
import 'package:companion/model/notes.model.dart';
import 'package:companion/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BookmarksSearchPage extends ConsumerStatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const BookmarksSearchPage());
  }

  const BookmarksSearchPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<BookmarksSearchPage> {
  List<NotesModel> foundedNotes = [];
  List<NotesModel> _notes = [];

  List<NotesModel> getBookmarks(List<NotesModel> allnotes, user) {
    List<NotesModel> bookmarks = [];
    var userbookmarklist =
        user?.bid?.map((id) => id.toString())?.toList() ?? [];

    for (var note in allnotes) {
      if (userbookmarklist.contains(note.fileId.toString())) {
        bookmarks.add(note);
      }
    }

    bookmarks = bookmarks.reversed.toList();
    return bookmarks;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ignore: todo
      // TODO: implement initState
      final allnotes = ref.read(notesDataProvider)!;
      var user = ref.watch(userDataProvider) ?? nullUser;
      _notes = getBookmarks(allnotes, user);
      setState(() {
        foundedNotes = _notes;
      });
    });
  }

  onSearch(String search) {
    setState(() {
      final allnotes = ref.read(notesDataProvider);
      var user = ref.watch(userDataProvider) ?? nullUser;
      _notes = getBookmarks(allnotes!, user);
      foundedNotes = _notes
          .where((notes) =>
              notes.name!.toLowerCase().contains(search) |
              notes.course!.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final allnotes = ref.read(notesDataProvider)!;
    var user = ref.watch(userDataProvider) ?? nullUser;
    var userbookmarklist = user?.bid ?? [''];
    List<NotesModel> bookmarks = [];
    List<NotesModel> getBookmarks() {
      Set<String> bookmarkFileIds = Set<String>.from(userbookmarklist);
      for (var note in allnotes) {
        if (bookmarkFileIds.contains(note.fileId.toString())) {
          bookmarks.add(note);
        }
      }
      bookmarks = bookmarks.reversed.toList();
      return bookmarks;
    }

    getBookmarks();
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
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
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              elevation: 0,
              backgroundColor: Pallete.backgroundColor,
              title: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(2)),
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(color: Pallete.whiteColor),
                  onChanged: (value) => onSearch(value.toLowerCase()),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(
                        OctIcons.search_16,
                        size: 20,
                        color: Pallete.whiteColor,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Pallete.whiteColor),
                      hintText: "Search in your library"),
                ),
              ),
            ),
            body: Container(
              margin: EdgeInsets.only(top: size.width * 0.05),
              color: Pallete.backgroundColor,
              child: foundedNotes.length > 0
                  ? ListView.builder(
                      itemCount:
                          foundedNotes.length > 15 ? 15 : foundedNotes.length,
                      itemBuilder: (context, index) {
                        return notesComponent(notes: foundedNotes[index]);
                      })
                  : const Center(
                      child: Text(
                      "No notes found",
                      style: TextStyle(
                        color: Pallete.whiteColor,
                      ),
                    )),
            ),
          ),
        ),
      ),
    );
  }

  notesComponent({required NotesModel notes}) {
    return InkWell(
      onLongPress: () {
        Navigator.push(context, NotesMenu.route(notes: notes));
      },
      onTap: () {
        recentlyAccessedBox.add(
            [notes.fileId!, DateTime.now().millisecondsSinceEpoch.toString()]);
        trendingBox.add(notes.fileId!);
        Navigator.push(context, NotesPdfView.route(notes: notes));
      },
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
                    notes.name!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    notes.course!,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              '${notes.unit} Unit',
              style: const TextStyle(color: Pallete.whiteColor, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
